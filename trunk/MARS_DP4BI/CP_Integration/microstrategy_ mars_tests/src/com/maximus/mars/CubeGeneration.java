package com.maximus.mars;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Enumeration;
import java.util.concurrent.ThreadLocalRandom;

import org.apache.commons.ssl.Base64;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthenticationException;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.util.EntityUtils;

import com.microstrategy.sdk.samples.writeback.FreeFormSqlWriter;
import com.microstrategy.selenium.action.mstrweb.cube.CubeCommon;
import com.microstrategy.utils.WebReportPropertiesHelper;
import com.microstrategy.utils.serialization.EnumWebPersistableState;
import com.microstrategy.web.app.beans.AppBeanFactory;
import com.microstrategy.web.app.beans.ReportFrameBean;
import com.microstrategy.web.app.taglibs.taskproc.DatasetTable;
import com.microstrategy.web.beans.BeanFactory;
import com.microstrategy.web.beans.ReportBean;
import com.microstrategy.web.beans.ViewBean;
import com.microstrategy.web.beans.WebBeanException;
import com.microstrategy.web.beans.WebException;
import com.microstrategy.web.objects.EnumWebReportSourceType;
import com.microstrategy.web.objects.SimpleList;
import com.microstrategy.web.objects.WebFolder;
import com.microstrategy.web.objects.WebIServerSession;
import com.microstrategy.web.objects.WebMDXCubeSource;
import com.microstrategy.web.objects.WebObjectInfo;
import com.microstrategy.web.objects.WebObjectSource;
import com.microstrategy.web.objects.WebObjectsException;
import com.microstrategy.web.objects.WebObjectsFactory;
import com.microstrategy.web.objects.WebPropertyGroup;
import com.microstrategy.web.objects.WebReportExecutionSettings;
import com.microstrategy.web.objects.WebReportInstance;
import com.microstrategy.web.objects.WebReportSource;
import com.microstrategy.web.objects.WebTemplate;
import com.microstrategy.web.objects.WebViewInstance;
import com.microstrategy.web.objects.WebVisualizationSettings;
import com.microstrategy.web.objects.WebVisualizationSettingsImpl;
import com.microstrategy.web.objects.WebWorkingSet;
import com.microstrategy.web.objects.dataimport.DatasetCreator;
import com.microstrategy.web.objects.dataimport.EnumDatasetType;
import com.microstrategy.webapi.EnumDSSXMLAuthModes;
import com.microstrategy.webapi.EnumDSSXMLDisplayMode;
import com.microstrategy.webapi.EnumDSSXMLExecutionFlags;
import com.microstrategy.webapi.EnumDSSXMLObjectTypes;
import com.microstrategy.webapi.EnumDSSXMLReportObjects;
import com.microstrategy.webapi.EnumDSSXMLReportSaveAsFlags;
import com.microstrategy.webapi.rest.RestFactory;

public class CubeGeneration {
	
	
	// Variables
	private static 	String username = ""; // fill with the user login
	private static String password = ""; // fill with the user password
	private static int loginMode = 16; //1 for standard connection, 16 for LDAP
	
	// Rest Variables
	private static String projectID = ""; // fill with a valid project ID 
	private static String res = "c:/test.json"; // change to the path where you save the test.json
	
	// SDK Variables
	private static String DIReportID = ""; // fill if a valid report ID
	private static String baseCubeID = ""; // fill with a valid report ID
	private static String projectName = ""; // fill with a valid project name
	private static String serverName = "ucocdmmapp01dat.maxcorp.maximus";
	private static int portNum = 12080;
	 

	public static void main(String[] args) {
		
		cubeRest();
		
		
		// Tests with the SDK
		/* 
		 * try { createIcubeReport(); } catch (WebBeanException e) {
		 * 
		 * e.printStackTrace(); } catch (WebObjectsException e) {
		 * 
		 * e.printStackTrace(); } catch (WebException e) {
		 * 
		 * e.printStackTrace(); }
		 */
		
	}

	public static void cubeRest() {
	
		String baseRestURL = "https://maxdat-dev.maximus.com/MicroStrategyLibrary";
		String cubeName = "MyCube";		
		String updatePolicy = "add";
		
		CookieStore httpCookieStore = new BasicCookieStore();		
		CloseableHttpClient httpClient = HttpClients.custom().setDefaultCookieStore(httpCookieStore).build();

		String authToken = createAuthToken(baseRestURL, httpClient, username, password, loginMode);
		System.out.println("Auth Token: " + authToken);

		if (authToken == null) {
			System.out.println("Error: Unable to generate authToken - check to see if server is running");
			return;
		}

		// The below sample will generate data that creates an Attribute of ID, and a
		// metric of Price

		// Create row(s) of data for cube:
		// int id_val = ThreadLocalRandom.current().nextInt(10000, 99999 + 1);
		// int price_val = ThreadLocalRandom.current().nextInt(10000, 99999 + 1);
		// String JSONString = "[{\"ID\":"+id_val+",\"Price\":"+price_val+"}]";
		// String base64EncodedData = encodeJSON(JSONString);

		// Read from a file
		String base64EncodedData = "";
		
		try {			
			
			byte[] encoded = Files.readAllBytes(Paths.get(res));
			String file = new String(encoded, (new FileReader(res)).getEncoding());
			base64EncodedData = encodeJSON("[" + file + "]");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// The table will define 2 columns called ID and Price of type 'double'. We will
		// then map the ID column to an attribute and the price column to a metric in
		// the table structure JSON.

		// define table structure
		String tableStructure = "{\"name\":\"" + cubeName + "\",\"tables\":[{\"data\":\"" + base64EncodedData
				+ "\",\"name\":\"Table\",\"columnHeaders\":[{\"name\":\"ID\",\"dataType\":\"DOUBLE\"},{\"name\":\"Price\",\"dataType\":\"DOUBLE\"}]}],\"metrics\":[{\"name\":\"Price\",\"dataType\":\"number\",\"expressions\":[{\"formula\":\"Table.Price\"}]}],\"attributes\":[{\"name\":\"ID\",\"attributeForms\":[{\"category\":\"ID\",\"expressions\":[{\"formula\":\"Table.ID\"}],\"dataType\":\"double\"}]}]}";
		
		// Create or update cube
		createCubeWithData(baseRestURL, authToken, httpClient, projectID, tableStructure, updatePolicy);
		
		

	}

	// Creates an AuthToken
	public static String createAuthToken(String baseRestURL, HttpClient httpClient, String username, String password,
			int loginMode) {
		String APIPath = "/api/auth/login";
		String completeRestURL = baseRestURL + APIPath;
		System.out.println("REST API URL: " + completeRestURL);

		try {

			HttpPost httpRequest = new HttpPost(completeRestURL);
			httpRequest.setHeader("Content-Type", "application/json");
			httpRequest.setHeader("Accept", "application/json");
			StringEntity body = new StringEntity(
					"{\"username\": \"" + username + "\",\"password\": \"" + password + "\",\"loginMode\": \"" + loginMode +"\"}");
			
			httpRequest.setEntity(body);

			HttpResponse response = httpClient.execute(httpRequest);

			Header[] headers = (Header[]) response.getAllHeaders();

			for (int i = 0; i < headers.length; i++) {
				Header header = headers[i];
				// System.out.println(header.getName() + " : " + header.getValue());
				if (header.getName().equalsIgnoreCase("X-MSTR-AuthToken")) {
					return header.getValue();
				}
			}

			return null;

		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	// Performs a POST Request to initially write data to a cube with the variables
	// provided
	public static String createCubeWithData(String baseRestURL, String authToken, HttpClient httpClient,
			String projectID, String tableStructure, String updatePolicy) {
		String APIPath = "/api/datasets";
		String completeRestURL = baseRestURL + APIPath;
		System.out.println("REST API URL: " + completeRestURL);

		try {
			HttpPost httpRequest = new HttpPost(completeRestURL);
			httpRequest.setHeader("Content-Type", "application/json");
			httpRequest.setHeader("Accept", "application/json");
			httpRequest.setHeader("X-MSTR-AuthToken", authToken);
			httpRequest.setHeader("X-MSTR-ProjectID", projectID);
			httpRequest.setHeader("updatePolicy", updatePolicy);
			StringEntity body;

			body = new StringEntity(tableStructure);
			httpRequest.setEntity(body);
			HttpResponse response = httpClient.execute(httpRequest);

			HttpEntity entity = response.getEntity();
			String responseString = EntityUtils.toString(entity, "UTF-8");
			System.out.println(responseString);

			return responseString;

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	public static String encodeJSON(String JSONString) {

		// encode data on your side using BASE64
		byte[] bytesEncoded = Base64.encodeBase64(JSONString.getBytes());
		// System.out.println("ecncoded value is " + new String(bytesEncoded ));
		String encoded = new String(bytesEncoded); // base64

		return encoded;
	}

	
	// Tests using the SDK
	public static void createIcubeReport() throws WebBeanException, WebObjectsException, WebException {
		
		WebIServerSession iSession = WebObjectsFactory.getInstance().getIServerSession();

		try {

			iSession.setServerName(serverName);
			iSession.setProjectName(projectName);
			iSession.setServerPort(portNum);
			iSession.setLogin(username);
			iSession.setPassword(password);
			iSession.setAuthMode(EnumDSSXMLAuthModes.DssXmlAuthLDAP);
			iSession.getSessionID();

			System.out.println(iSession.getSessionID());

			String sessState = iSession.saveState(EnumWebPersistableState.MINIMAL_STATE_INFO);
			System.out.println(sessState);

			// Report
			WebObjectsFactory woFact = iSession.getFactory();
			WebReportSource reptSrc = woFact.getReportSource();
			WebObjectSource os = woFact.getObjectSource();
			WebMDXCubeSource cs = os.getMDXCubeSource();

			reptSrc.setExecutionFlags(EnumDSSXMLExecutionFlags.DssXmlExecutionFresh);

			WebReportInstance rptInst = reptSrc.getNewInstance(baseCubeID);

			WebFolder wf = (WebFolder) os.getObject(baseCubeID, EnumDSSXMLObjectTypes.DssXmlTypeReportDefinition)
					.getParent();

			WebObjectInfo wi = rptInst.saveAs(wf, "testnewcube"); // Returning error, if use the 

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			iSession.closeSession();
		}
	}
}
