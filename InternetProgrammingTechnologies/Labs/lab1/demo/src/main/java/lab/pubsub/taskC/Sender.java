package lab.pubsub.taskC;

import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;

import javax.jms.Destination;
import javax.jms.JMSContext;

public class Sender {
    public static void main(String[] args) {
        ConnectionFactory cf=new ConnectionFactory();
        try(JMSContext context= cf.createContext("admin","admin")){
            cf.setProperty(ConnectionConfiguration.imqAddressList,"mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination ex3=context.createTopic("Ex_3c");
            context.createProducer().send(ex3,"Hello, World");
            System.out.println("Message has been sent...");
        }
        catch(Exception e){
            System.out.println(e.getMessage());
        }
    }
}
