package graphapponlytutorial;
import java.util.List;
import java.util.Properties;
import com.azure.core.credential.AccessToken;
import com.azure.core.credential.TokenRequestContext;
import com.azure.identity.ClientSecretCredential;
import com.azure.identity.ClientSecretCredentialBuilder;
import com.microsoft.graph.models.BodyType;
import com.microsoft.graph.models.EmailAddress;
import com.microsoft.graph.models.ItemBody;
import com.microsoft.graph.models.Message;
import com.microsoft.graph.models.MessageCollectionResponse;
import com.microsoft.graph.models.Recipient;
import com.microsoft.graph.models.User;
import com.microsoft.graph.models.UserCollectionResponse;
import com.microsoft.graph.serviceclient.GraphServiceClient;
import com.microsoft.graph.users.item.sendmail.SendMailPostRequestBody;

public class EmailGraph {
    private static Properties _properties;
    private static ClientSecretCredential clientSecretCredential;
    private static GraphServiceClient graphServiceClient;

    public static void initializeGraphForAppOnlyAuth(Properties properties) throws Exception {
        // Ensure properties isn't null
        if (properties == null) {
            throw new Exception("Properties cannot be null");
        }

        _properties = properties;

        if (clientSecretCredential == null) {
            final String clientId = _properties.getProperty("app.clientId");
            final String tenantId = _properties.getProperty("app.tenantId");
            final String clientSecret = _properties.getProperty("app.clientSecret");

            clientSecretCredential = new ClientSecretCredentialBuilder()
                .clientId(clientId)
                .tenantId(tenantId)
                .clientSecret(clientSecret)
                .build();
        }

        if (graphServiceClient == null) {
        	graphServiceClient = new GraphServiceClient(clientSecretCredential,
                    new String[] { "https://graph.microsoft.com/.default" });
        }
    }
    public static String getAppOnlyToken() throws Exception {
        if (clientSecretCredential == null) {
            throw new Exception("Graph has not been initialized for app-only auth");
        }

        final String[] graphScopes = new String[] {"https://graph.microsoft.com/.default"};
        final TokenRequestContext context = new TokenRequestContext();
        context.addScopes(graphScopes);
        final AccessToken token = clientSecretCredential.getToken(context).block();
        return token.getToken();
    }
    public static UserCollectionResponse getUsers() throws Exception {
        if (graphServiceClient == null) {
            throw new Exception("Graph has not been initialized for app-only auth");
        }

        return graphServiceClient.users().get(requestConfig -> {
            requestConfig.queryParameters.select = new String[] { "displayName", "id", "mail" };
            requestConfig.queryParameters.top = 25;
            requestConfig.queryParameters.orderby = new String[] { "displayName" };
        });
    }
    public static void makeGraphCall() {
        // INSERT YOUR CODE HERE
    }
    
	public static void sendMail(String subject, String body, String recipient) throws Exception {
		if (graphServiceClient == null) {
			throw new Exception("Graph has not been initialized for user auth");
		}
		// Create a new message
		final Message message = new Message();
		message.setSubject(subject);
		final ItemBody itemBody = new ItemBody();
		itemBody.setContent(body);
		itemBody.setContentType(BodyType.Text);
		message.setBody(itemBody);
		final EmailAddress emailAddress = new EmailAddress();
		emailAddress.setAddress(recipient);
		final Recipient toRecipient = new Recipient();
		toRecipient.setEmailAddress(emailAddress);
		message.setToRecipients(List.of(toRecipient));
		final SendMailPostRequestBody postRequest = new SendMailPostRequestBody();
		postRequest.setMessage(message);
		graphServiceClient.me().sendMail().post(postRequest);
	}
	
	public static User getUser() throws Exception {
		if (graphServiceClient == null) {
			throw new Exception("Graph has not been initialized for user auth");
		}
		return graphServiceClient.me().get(requestConfig -> {
			requestConfig.queryParameters.select = new String[] { "displayName", "mail", "userPrincipalName" };
		});
	}

	public static MessageCollectionResponse getInbox() throws Exception {
		if (graphServiceClient == null) {
			throw new Exception("Graph has not been initialized for user auth");
		}
		return graphServiceClient.me().mailFolders().byMailFolderId("inbox").messages().get(requestConfig -> {
			requestConfig.queryParameters.select = new String[] { "from", "isRead", "receivedDateTime", "subject" };
			requestConfig.queryParameters.top = 25;
			requestConfig.queryParameters.orderby = new String[] { "receivedDateTime DESC" };
		});
	}
}
