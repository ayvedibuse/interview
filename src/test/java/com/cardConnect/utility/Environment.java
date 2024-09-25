package com.cardConnect.utility;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class Environment {

    //constants
    public static final String UI_URL;
    public static final String API_BASE_URI;
    public static final String DB_USERNAME;
    public static final String DB_PASSWORD;
    public static final String DB_URL;
    public static final String USER1_EMAIL;
    public static final String USER1_PASSWORD;
    public static final String USER2_EMAIL;
    public static final String USER2_PASSWORD;


    static{
        Properties properties = null;
        String environment = System.getProperty("environment") != null ? environment = System.getProperty("environment") : ConfigurationReader.getProperty("environment");
        //this field will get its value from configuration.properties file environment key /qa1 dev stg
        //String environment = ConfigurationReader.getProperty("environment");


        try {
            //where is our file ?, path is holding that one
            String path = System.getProperty("user.dir") + "/src/test/resources/environments/" + environment + ".properties";

            FileInputStream input = new FileInputStream(path);
            properties = new Properties();
            properties.load(input);
            input.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        UI_URL = properties.getProperty("ui_url");
        API_BASE_URI = properties.getProperty("api.baseUri");
        DB_USERNAME = properties.getProperty("db.username");
        DB_PASSWORD = properties.getProperty("db.password");
        DB_URL = properties.getProperty("db.url");
        USER1_EMAIL = properties.getProperty("user1_username");
        USER1_PASSWORD = properties.getProperty("user1_password");
        USER2_EMAIL = properties.getProperty("user2_username");
        USER2_PASSWORD = properties.getProperty("user2_password");



    }


}





