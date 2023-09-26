package com.maximus.amp.webapp.controller;

import java.net.BindException;
import java.nio.charset.Charset;
import java.util.Random;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.subethamail.wiser.Wiser;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"classpath:/applicationContext-props.xml",
    "classpath:/applicationContext-resources.xml",
    "classpath:/applicationContext-dao.xml",
    "classpath:/applicationContext-service.xml",
    "classpath*:/applicationContext.xml", // for modular archetypes
    "/WEB-INF/applicationContext*.xml",
    "/WEB-INF/dispatcher-servlet.xml",
    "/WEB-INF/security.xml"
})
public abstract class BaseControllerTestCase {
    
	protected transient final Log log = LogFactory.getLog(getClass());
    private int smtpPort;
    
    public static final MediaType APPLICATION_JSON_UTF8 = new MediaType(MediaType.APPLICATION_JSON.getType(),MediaType.APPLICATION_JSON.getSubtype(),Charset.forName("utf8"));

    @Autowired
    private JavaMailSenderImpl mailSender;

    @Before
    public void onSetUp() {
        smtpPort = (new Random().nextInt(9999 - 1000) + 1000);
        log.debug("SMTP Port set to: " + smtpPort);
    }

    protected int getSmtpPort() {
        return smtpPort;
    }

    protected Wiser startWiser(int smtpPort) {
        Wiser wiser = new Wiser();
        wiser.setPort(smtpPort);
        try {
            wiser.start();
        } catch (RuntimeException re) {
            if (re.getCause() instanceof BindException) {
                int nextPort = smtpPort + 1;
                if (nextPort - smtpPort > 10) {
                    log.error("Exceeded 10 attempts to start SMTP server, aborting...");
                    throw re;
                }
                log.error("SMTP port " + smtpPort + " already in use, trying " + nextPort);
                return startWiser(nextPort);
            }
        }
        mailSender.setPort(smtpPort);
        return wiser;
    }
}
