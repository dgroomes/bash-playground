package dgroomes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.module.paramnames.ParameterNamesModule;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * The class with the main method. Normally, this is the entry point for a project. But in this case, you should avoid
 * running the main method in this class and instead try to load the code using jshell. See the README.md.
 */
public class Main {

    private static Logger log = LoggerFactory.getLogger(Main.class);

    public static ObjectMapper objectMapper() {
        return new ObjectMapper();
    }

    public static ObjectMapper objectMapperWithParamNames() {
        return new ObjectMapper().registerModule(new ParameterNamesModule());
    }

    public static String POINT_JSON = """
            {
               "x": 1,
               "y": 2
            }
            """;

    public static void main(String[] args) {
        log.error("Don't run the main method, use jshell! See the README.md");
    }
}
