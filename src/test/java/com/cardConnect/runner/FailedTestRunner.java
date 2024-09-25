package com.cardConnect.runner;


import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = "/Users/buseayvedi/IdeaProjects/LibraryAllInOne/target/surefire-reports",
        glue = "com/cardConnect/steps"

)
public class FailedTestRunner {

}
