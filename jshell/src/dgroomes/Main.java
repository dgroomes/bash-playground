package dgroomes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.module.paramnames.ParameterNamesModule;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * The class with the main method. Normally, this is the entry point for a project. But in this case, you should avoid
 * running the main method in this class and instead try to load the code using jshell. See the README.md for more
 * information.
 */
public class Main {

    private static final Logger log = LoggerFactory.getLogger(Main.class);

    public static String POINT_JSON = """
            {
               "x": 1,
               "y": 2
            }
            """;

    public static void main(String[] args) throws JsonProcessingException {
        log.warn("""
                Here is a typical example of writing exploratory code inside of a `public static void main` method. In
                it, we explore the Jackson library and experiment with using the ObjectMapper with Java 14's new 
                "Records" language feature. This approach works fine, but it requires a full re-build and 're-run to
                completion' to see the results of a code change. An IDE or build tool like Gradle makes this pretty easy
                *if you have already installed and configured these tools*. Alternatively, with no additional tools
                beyond the JDK, we can get a fast-feedback development cycle with a Read-Evaluate-Print-Loop courtesy of
                jshell, the Java shell. This is perfect for absolute beginners where time is of the essence to build up
                their confidence and interest in the language. See the README.md for more information.
                """);

        var mapper = new ObjectMapper();
        var mapperWithParamNames = new ObjectMapper().registerModule(new ParameterNamesModule());

        {
            var point = mapper.readValue(POINT_JSON, PointPojo.class);
            log.info("Found {} using a plain ObjectMapper to deserialize into a plain Pojo class", point);
        }

        try {
            mapper.readValue(POINT_JSON, PointRecord.class);
        } catch (JsonProcessingException e) {
            log.info("As expected, failed to use a plain ObjectMapper to deserialize into a record class. The error was {}", e.toString());
        }

        {
            var point = mapperWithParamNames.readValue(POINT_JSON, PointRecord.class);
            log.info("Found {} using an ObjectMapper configured with the ParameterNamesModule to deserialize into a record class", point);
        }

    }
}
