package graphapponlytutorial;
import java.io.IOException;
import java.util.Properties;
import com.microsoft.graph.models.User;
import com.microsoft.graph.models.UserCollectionResponse;

public class EmailTest {
    public static void main(String[] args) throws Exception {
        System.out.println("Java App-Only Graph");
        final Properties oAuthProperties = new Properties();
        try {
            oAuthProperties.load(EmailTest.class.getResourceAsStream("oAuth.properties"));
        } catch (IOException e) {
            System.out.println("Unable to read OAuth configuration. Make sure you have a properly formatted oAuth.properties file. See README for details.");
            return;
        }
        initializeGraph(oAuthProperties);
        displayAccessToken();
        listUsers() ;
        EmailGraph.getInbox();
       // EmailGraph.sendMail("Hello subject", "body Test", "rajdevm@outlook.com");

    }
    private static void initializeGraph(Properties properties) {
        try {
            EmailGraph.initializeGraphForAppOnlyAuth(properties);
        } catch (Exception e)
        {
            System.out.println("Error initializing Graph for user auth");
            System.out.println(e.getMessage());
        }
    }
    private static void displayAccessToken() {
        try {
            final String accessToken = EmailGraph.getAppOnlyToken();
            System.out.println("Access token: " + accessToken);
        } catch (Exception e) {
            System.out.println("Error getting access token");
            System.out.println(e.getMessage());
        }
    }
    private static void listUsers() {
        try {
            final UserCollectionResponse users = EmailGraph.getUsers();
            // Output each user's details
            for (User user: users.getValue()) {
                System.out.println("User: " + user.getDisplayName());
                System.out.println("  ID: " + user.getId());
                System.out.println("  Email: " + user.getMail());
            }

            final Boolean moreUsersAvailable = users.getOdataNextLink() != null;
            System.out.println("\nMore users available? " + moreUsersAvailable);
        } catch (Exception e) {
            System.out.println("Error getting users");
            System.out.println(e.getMessage());
        }
    }
    private static void makeGraphCall() {
        try {
            EmailGraph.makeGraphCall();
        } catch (Exception e) {
            System.out.println("Error making Graph call");
            System.out.println(e.getMessage());
        }
    }
}
