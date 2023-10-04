import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;

import jakarta.jms.*;

public class Receiver implements MessageListener{
    ConnectionFactory cf = new com.sun.messaging.ConnectionFactory();
    JMSConsumer consumer;
    Receiver() {
        try (JMSContext context = cf.createContext("admin", "admin")) {
            cf.setProperty(ConnectionConfiguration.imqAddressList, "mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination messageQueue = context.createQueue("Servlet");
            consumer = context.createConsumer(messageQueue);
            consumer.setMessageListener(this);
            System.out.println("Listening on Servlet");
            Thread.sleep(1000000);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    @Override
    public void onMessage(Message message) {
        try{
            System.out.println("Message from servlet: " + message.getBody(String.class));
        } catch (JMSException e){
            System.err.println("JMSException: " + e.toString());
        }
    }
    public static void main(String[] args) {
        new Receiver();
    }
}
