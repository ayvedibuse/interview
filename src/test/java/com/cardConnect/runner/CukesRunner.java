package com.cardConnect.runner;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(

        plugin = {
                "html:target/cucumber-report.html", // classic cucumber report
                "rerun:target/rerun.txt" , // Generates rerun file in the specified directory
                "me.jvt.cucumber.report.PrettyReports:target/cucumber", // pretty report
                "json:target/cucumber.json",

        },
        features = "src/test/resources/features" ,
        glue = "com/cardConnect/steps",
        dryRun = false,
        tags = "",
        publish = true
)
public class CukesRunner {

}




