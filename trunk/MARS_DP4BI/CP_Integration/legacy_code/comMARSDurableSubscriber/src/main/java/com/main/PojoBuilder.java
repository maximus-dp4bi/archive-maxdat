package com.main;

import com.google.gson.*;
import com.pojo.MarsContactRecordEvents;
import org.apache.commons.lang.StringUtils;

import javax.jms.TextMessage;
import java.awt.*;
import java.lang.reflect.Type;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.Locale;

public class PojoBuilder {

    private static Object pojo;
    private static TextMessage msg;
    private static String jsonMessageinitial;
    private static String eventNameType;
    private static String[] eventNameTypeArr;
    private String eventName;
    private String eventType;
    private static Gson gson;
    private org.hibernate.Session hibernateSession;

    public PojoBuilder(org.hibernate.Session hibernateSession){
        this.hibernateSession = hibernateSession;
        gson = new Gson();

    }

    public void setTextMessage(TextMessage msg){
        this.msg = msg;
    }

    public Object buildPojo(){



        try {
            jsonMessageinitial = msg.getText();
            eventNameType = msg.getStringProperty("EventName");
            eventNameTypeArr = parseEventNameType(eventNameType);
            eventName = eventNameTypeArr[0];
            eventType = eventNameTypeArr[1];
        }
        catch(Exception e){
            e.getStackTrace();
        }

        MarsContactRecordEvents customObject = null;


        switch(eventName){
            case "CONTACT_RECORD":
                System.out.println("Inside Contact Record eventType is " + eventType);

                GsonBuilder gsonBuilder = new GsonBuilder();
                if (eventType.equals("SAVE")){
                    System.out.println("Inside Contact Record SAVE");
                    JsonDeserializer<MarsContactRecordEvents> deserializer = new JsonDeserializer<MarsContactRecordEvents>() {
                        JsonElement checker = null;

                        @Override
                        public MarsContactRecordEvents deserialize(JsonElement jsonElement, Type type, JsonDeserializationContext jsonDeserializationContext) throws JsonParseException {

                            JsonObject jsonObject = jsonElement.getAsJsonObject();
                            MarsContactRecordEvents obj = new MarsContactRecordEvents();

                            checker = jsonObject.get("contactRecordId");
                            if (checker != null) {
                                obj.setContactRecordId(checker.getAsLong());
                            }
                            checker = jsonObject.get("contactRecordType");
                            if (checker != null) {
                                obj.setContactRecordType(checker.getAsString());
                            }
                            checker = jsonObject.get("consumerType");
                            if (checker != null) {
                                obj.setConsumerType(checker.getAsString());
                            }
                            checker = jsonObject.get("preferredLanguage");
                            if (checker != null) {
                                obj.setPreferredLanguageCode(checker.getAsString());
                            }
                            /*checker = jsonObject.get("contactRecordStartTime");
                            if (checker != null) {
                                obj.setContactRecordStartTime(checker.getAsString());
                            }*/
                            /*checker = jsonObject.get("contactRecordEndTime");
                            if (checker != null) {
                                obj.setContactRecordEndTime(checker.getAsString());
                            }*/
                            checker = jsonObject.get("consumerPhone");
                            if (checker != null) {
                                obj.setConsumerPhone(checker.getAsString());
                            }
                            checker = jsonObject.get("consumerFirstName");
                            if (checker != null) {
                                obj.setConsumerFirstName(checker.getAsString());
                            }
                            checker = jsonObject.get("consumerLastName");
                            if (checker != null) {
                                obj.setConsumerLastName(checker.getAsString());
                            }
                            checker = jsonObject.get("consumerEmail");
                            if (checker != null) {
                                obj.setConsumerEmail(checker.getAsString());
                            }
                            checker = jsonObject.get("contactRecordStatusType");
                            if (checker != null) {
                                obj.setContactRecordStatusType(checker.getAsString());
                            }
                            checker = jsonObject.get("consumerAuthenticatedInd");
                            if (checker != null) {
                                obj.setConsumerAuthenticatedInd(checker.getAsString());
                            }
                            checker = jsonObject.get("createdBy");
                            if (checker != null) {
                                obj.setCreatedBy(checker.getAsString());
                            }
                            checker = jsonObject.get("createdOn");
                            if (checker != null) {
                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d, yyyy hh:mm:ss a", Locale.ENGLISH);
                                LocalDateTime dateTime = LocalDateTime.parse(checker.getAsString(), formatter);
                                obj.setCreatedOn(dateTime);
                            }
                            checker = jsonObject.get("updatedBy");
                            if (checker != null) {
                                obj.setUpdatedBy(checker.getAsString());
                            }
                            if (checker != null) {
                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d, yyyy hh:mm:ss a", Locale.ENGLISH);
                                LocalDateTime dateTime = LocalDateTime.parse(checker.getAsString(), formatter);
                                obj.setUpdatedOn(dateTime);
                            }
                            checker = jsonObject.get("genericFieldText1");
                            if (checker != null) {
                                obj.setGenericField1Txt(checker.getAsString());
                            }
                            checker = jsonObject.get("genericFieldText2");
                            if (checker != null) {
                                obj.setGenericField2Txt(checker.getAsString());
                            }
                            checker = jsonObject.get("genericFieldText3");
                            if (checker != null) {
                                obj.setGenericField3Txt(checker.getAsString());
                            }
                            checker = jsonObject.get("genericFieldText4");
                            if (checker != null) {
                                obj.setGenericField4Txt(checker.getAsString());
                            }
                            checker = jsonObject.get("genericFieldNumber1");
                            if (checker != null) {
                                obj.setGenericField1Num(checker.getAsLong());
                            }
                            checker = jsonObject.get("genericFieldNumber2");
                            if (checker != null) {
                                obj.setGenericField2Num(checker.getAsLong());
                            }
                            checker = jsonObject.get("genericFieldNumber3");
                            if (checker != null) {
                                obj.setGenericField3Num(checker.getAsLong());
                            }
                            checker = jsonObject.get("genericFieldNumber4");
                            if (checker != null) {
                                obj.setGenericField4Num(checker.getAsLong());
                            }
                            /*checker = jsonObject.get("genericFieldDate1");
                            if (checker != null) {
                                obj.setGenericField1Date(checker.getAsLong());
                            }
                            checker = jsonObject.get("genericFieldDate2");
                            if (checker != null) {
                                obj.setGenericField2Date(checker.getAsLong());
                            }
                            checker = jsonObject.get("genericFieldDate3");
                            if (checker != null) {
                                obj.setGenericField3Date(checker.getAsLong());
                            }
                            checker = jsonObject.get("genericFieldDate4");
                            if (checker != null) {
                                obj.setGenericField4Date(checker.getAsLong());
                            }*/
                            checker = jsonObject.get("linkRefId");
                            if (checker != null) {
                                obj.setLinkRefId(checker.getAsDouble());
                            }
                            checker = jsonObject.get("linkRefType");
                            if (checker != null) {
                                obj.setLinkRefType(checker.getAsString());
                            }
                            checker = jsonObject.get("correlationId");
                            if (checker != null) {
                                obj.setCorrelationId(checker.getAsString());
                            }
                            checker = jsonObject.get("uiid");
                            if (checker != null) {
                                obj.setUiid(checker.getAsString());
                            }
                            checker = jsonObject.get("wrapUpTime");
                            if (checker != null) {
                                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d, yyyy hh:mm:ss a", Locale.ENGLISH);
                                LocalDateTime dateTime = LocalDateTime.parse(checker.getAsString(), formatter);
                                obj.setWrapUpTime(dateTime);
                            }
                            checker = jsonObject.get("callDuration");
                            if (checker != null) {
                                obj.setCallDuration(checker.getAsInt());
                            }
                            checker = jsonObject.get("inboundCallQueue");
                            if (checker != null) {
                                obj.setInboundCallQueue(checker.getAsString());
                            }
                            checker = jsonObject.get("contactChannelType");
                            if (checker != null) {
                                obj.setContactChannelType(checker.getAsString());
                            }
                            checker = jsonObject.get("contactCampaignType");
                            if (checker != null) {
                                obj.setContactCompaignType(checker.getAsString());
                            }
                            checker = jsonObject.get("contactReasonEditType");
                            if (checker != null) {
                                obj.setContactReasonEditType(checker.getAsString());
                            }
                            checker = jsonObject.get("contactOutcome");
                            if (checker != null) {
                                obj.setContactOutcome(checker.getAsString());
                            }
                            checker = jsonObject.get("organizationName");
                            if (checker != null) {
                                obj.setOrganizationName(checker.getAsString());
                            }
                            checker = jsonObject.get("contactType");
                            if (checker != null) {
                                obj.setContactType(checker.getAsString());
                            }

                            return obj;

                        }
                    };
                    gsonBuilder.registerTypeAdapter(MarsContactRecordEvents.class, deserializer);

                    Gson customGson = gsonBuilder.create();
                    customObject = customGson.fromJson(jsonMessageinitial, MarsContactRecordEvents.class);

                    break;
                }
                else if (eventType.equals("UPDATE")){

                    System.out.println("Inside UPDATE is");
                    JsonDeserializer<MarsContactRecordEvents> deserializer = new JsonDeserializer<MarsContactRecordEvents>() {

                        MarsContactRecordEvents obj;
                        @Override
                        public MarsContactRecordEvents deserialize(JsonElement jsonElement, Type type, JsonDeserializationContext jsonDeserializationContext) throws JsonParseException {
                            System.out.println("Bleh");
                            JsonObject jsonObject = jsonElement.getAsJsonObject();
                            System.out.println("Bloh");
                            System.out.println("BlohContact record id is " + jsonObject.get("contactRecordId").getAsInt());
                            System.out.println("Is Hibernate session open: " + hibernateSession.isOpen());
                            //obj = hibernateSession.get(MarsContactRecordEvents.class, jsonObject.get("contactRecordId").getAsInt());
                            obj = hibernateSession.byId(MarsContactRecordEvents.class).load(jsonObject.get("contactRecordId").getAsLong());
                            System.out.println("Contact record id is " + jsonObject.get("contactRecordId").getAsLong());
                            System.out.println("Retrieved obj is " + obj);
                            if(obj!= null) {

                            JsonElement checker = null;

                            System.out.println("Inside UPDATE, Mars CR obj is " + obj);

                                checker = jsonObject.get("contactRecordType");
                                if (checker != null) {
                                    obj.setContactRecordType(checker.getAsString());
                                }
                                checker = jsonObject.get("consumerType");
                                if (checker != null) {
                                    obj.setConsumerType(checker.getAsString());
                                }
                                checker = jsonObject.get("preferredLanguage");
                                if (checker != null) {
                                    obj.setPreferredLanguageCode(checker.getAsString());
                                }
                            /*checker = jsonObject.get("contactRecordStartTime");
                            if (checker != null) {
                                obj.setContactRecordStartTime(checker.getAsString());
                            }*/
                            /*checker = jsonObject.get("contactRecordEndTime");
                            if (checker != null) {
                                obj.setContactRecordEndTime(checker.getAsString());
                            }*/
                                checker = jsonObject.get("consumerPhone");
                                if (checker != null) {
                                    obj.setConsumerPhone(checker.getAsString());
                                }
                                checker = jsonObject.get("consumerFirstName");
                                if (checker != null) {
                                    obj.setConsumerFirstName(checker.getAsString());
                                }
                                checker = jsonObject.get("consumerLastName");
                                if (checker != null) {
                                    obj.setConsumerLastName(checker.getAsString());
                                }
                                checker = jsonObject.get("consumerEmail");
                                if (checker != null) {
                                    obj.setConsumerEmail(checker.getAsString());
                                }
                                checker = jsonObject.get("contactRecordStatusType");
                                if (checker != null) {
                                    obj.setContactRecordStatusType(checker.getAsString());
                                }
                                checker = jsonObject.get("consumerAuthenticatedInd");
                                if (checker != null) {
                                    obj.setConsumerAuthenticatedInd(checker.getAsString());
                                }
                                checker = jsonObject.get("createdBy");
                                if (checker != null) {
                                    obj.setCreatedBy(checker.getAsString());
                                }
                                checker = jsonObject.get("createdOn");
                                if (checker != null) {
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d, yyyy hh:mm:ss a", Locale.ENGLISH);
                                    LocalDateTime dateTime = LocalDateTime.parse(checker.getAsString(), formatter);
                                    obj.setCreatedOn(dateTime);
                                }
                                checker = jsonObject.get("updatedBy");
                                if (checker != null) {
                                    obj.setUpdatedBy(checker.getAsString());
                                }
                                checker = jsonObject.get("updatedOn");
                                if (checker != null) {
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM d, yyyy hh:mm:ss a", Locale.ENGLISH);
                                    LocalDateTime dateTime = LocalDateTime.parse(checker.getAsString(), formatter);
                                    obj.setUpdatedOn(dateTime);
                                }
                                checker = jsonObject.get("genericFieldText1");
                                if (checker != null) {
                                    obj.setGenericField1Txt(checker.getAsString());
                                }
                                checker = jsonObject.get("genericFieldText2");
                                if (checker != null) {
                                    obj.setGenericField2Txt(checker.getAsString());
                                }
                                checker = jsonObject.get("genericFieldText3");
                                if (checker != null) {
                                    obj.setGenericField3Txt(checker.getAsString());
                                }
                                checker = jsonObject.get("genericFieldText4");
                                if (checker != null) {
                                    obj.setGenericField4Txt(checker.getAsString());
                                }
                                checker = jsonObject.get("genericFieldNumber1");
                                if (checker != null) {
                                    obj.setGenericField1Num(checker.getAsLong());
                                }
                                checker = jsonObject.get("genericFieldNumber2");
                                if (checker != null) {
                                    obj.setGenericField2Num(checker.getAsLong());
                                }
                                checker = jsonObject.get("genericFieldNumber3");
                                if (checker != null) {
                                    obj.setGenericField3Num(checker.getAsLong());
                                }
                                checker = jsonObject.get("genericFieldNumber4");
                                if (checker != null) {
                                    obj.setGenericField4Num(checker.getAsLong());
                                }
                            /*checker = jsonObject.get("genericFieldDate1");
                            if (checker != null) {
                                obj.setGenericField1Date(checker.getAsLong());
                            }
                            checker = jsonObject.get("genericFieldDate2");
                            if (checker != null) {
                                obj.setGenericField2Date(checker.getAsLong());
                            }
                            checker = jsonObject.get("genericFieldDate3");
                            if (checker != null) {
                                obj.setGenericField3Date(checker.getAsLong());
                            }
                            checker = jsonObject.get("genericFieldDate4");
                            if (checker != null) {
                                obj.setGenericField4Date(checker.getAsLong());
                            }*/
                                checker = jsonObject.get("linkRefId");
                                if (checker != null) {
                                    obj.setLinkRefId(checker.getAsDouble());
                                }
                                checker = jsonObject.get("linkRefType");
                                if (checker != null) {
                                    obj.setLinkRefType(checker.getAsString());
                                }
                                checker = jsonObject.get("correlationId");
                                if (checker != null) {
                                    obj.setCorrelationId(checker.getAsString());
                                }
                                checker = jsonObject.get("uiid");
                                if (checker != null) {
                                    obj.setUiid(checker.getAsString());
                                }
                            /*checker = jsonObject.get("wrapUpTime");
                            if (checker != null) {
                                obj.setWrapUpTime(checker.getAsString());
                            }*/
                                checker = jsonObject.get("callDuration");
                                if (checker != null) {
                                    obj.setCallDuration(checker.getAsInt());
                                }
                                checker = jsonObject.get("inboundCallQueue");
                                if (checker != null) {
                                    obj.setInboundCallQueue(checker.getAsString());
                                }
                                checker = jsonObject.get("contactChannelType");
                                if (checker != null) {
                                    obj.setContactChannelType(checker.getAsString());
                                }
                                checker = jsonObject.get("contactCampaignType");
                                if (checker != null) {
                                    obj.setContactCompaignType(checker.getAsString());
                                }
                                checker = jsonObject.get("contactReasonEditType");
                                if (checker != null) {
                                    obj.setContactReasonEditType(checker.getAsString());
                                }
                                checker = jsonObject.get("contactOutcome");
                                if (checker != null) {
                                    obj.setContactOutcome(checker.getAsString());
                                }
                                checker = jsonObject.get("organizationName");
                                if (checker != null) {
                                    obj.setOrganizationName(checker.getAsString());
                                }
                                checker = jsonObject.get("contactType");
                                if (checker != null) {
                                    obj.setContactType(checker.getAsString());
                                }

                        }
                            return obj;

                        }
                    };
                    gsonBuilder.registerTypeAdapter(MarsContactRecordEvents.class, deserializer);

                    Gson customGson = gsonBuilder.create();
                    customObject = customGson.fromJson(jsonMessageinitial, MarsContactRecordEvents.class);
                    break;
                }
        }

        System.out.println("finished onMessage");
        return customObject;
    }

    public String[] parseEventNameType(String eventNameType){

        String nameTypeStr = StringUtils.substring(eventNameType, 0, eventNameType.length()-6);
        String splitStr[] = new String[2];
        int lastUnderScore = nameTypeStr.lastIndexOf("_");
        String eventName = nameTypeStr.substring(0, lastUnderScore);
        String eventType = nameTypeStr.substring(lastUnderScore+1);
        splitStr[0] = eventName;
        splitStr[1] = eventType;

        return splitStr;
    }
}
