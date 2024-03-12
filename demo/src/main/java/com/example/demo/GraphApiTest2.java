package com.example.demo;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import com.azure.identity.UsernamePasswordCredential;
import com.azure.identity.UsernamePasswordCredentialBuilder;
import com.microsoft.graph.models.User;
import com.microsoft.graph.requests.GraphServiceClient;
import com.azure.identity.ClientSecretCredential;
import com.azure.identity.ClientSecretCredentialBuilder;
import com.microsoft.graph.authentication.TokenCredentialAuthProvider;
import com.microsoft.graph.models.*;
//https://learn.microsoft.com/en-us/graph/sdks/choose-authentication-providers?tabs=java
public class GraphApiTest2 {

	public static void main(String[] args) throws Exception {
		final String clientId = "";
		final String tenantId = ""; // or "common" for multi-tenant apps
		final String userName = "rajdevmaurya@gmail.com	";
		final String password = "";
		final String clientSecret = "";
		 final ClientSecretCredential clientSecretCredential = new ClientSecretCredentialBuilder()
	                .clientId(clientId)
	                .clientSecret(clientSecret)
	                .tenantId(tenantId)
	                .build();

	        List<String> scopes = new ArrayList<>();
	        scopes.add("https://graph.microsoft.com/.default");

	        final TokenCredentialAuthProvider tokenCredentialAuthProvider = new TokenCredentialAuthProvider(scopes, clientSecretCredential);


	        final GraphServiceClient graphClient =
	                GraphServiceClient
	                        .builder()
	                        .authenticationProvider(tokenCredentialAuthProvider)
	                        .buildClient();
	        System.out.println( graphClient.me().activities());
	        Message message = new Message();
	        message.subject = "Billing Report - " ;
	        graphClient.users("rajdevmaurya@gmail.com")
            .sendMail(UserSendMailParameterSet
                    .newBuilder()
                    .withMessage(message)
                    .withSaveToSentItems(true)
                    .build())
            .buildRequest()
            .post();
	}

}
