package com.main;

public class Controller {

    public static void main(String[] args){

        new Thread() {
            public void run() {
                new Worker();
            }}.start();
        System.out.println("Ended in Main");

    }
}
