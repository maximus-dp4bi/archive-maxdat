package com.main;

import com.hibernate.HibernateUtil;
import com.pojo.MarsContactRecordEvents;

public class Test {

    private static org.hibernate.SessionFactory hibernateSessionFactory;
    private static MarsContactRecordEvents obj;
    public static void main(String[] args){

        hibernateSessionFactory = HibernateUtil.createSessionFactory();
        org.hibernate.Session hibernateSession = hibernateSessionFactory.openSession();
        obj = hibernateSession.get(MarsContactRecordEvents.class, new Long(13428));
        System.out.println("obj is " + obj.getContactRecordId());

    }
}
