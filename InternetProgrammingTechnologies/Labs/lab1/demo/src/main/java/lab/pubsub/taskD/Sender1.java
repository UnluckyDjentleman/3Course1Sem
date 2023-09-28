package lab.pubsub.taskD;

import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;

import javax.jms.Destination;
import javax.jms.JMSContext;
import javax.jms.JMSProducer;
import javax.jms.TextMessage;

public class Sender1 {
    public static void main(String[] args) {
        ConnectionFactory cf=new ConnectionFactory();
        try(JMSContext context= cf.createContext("admin","admin")){
            cf.setProperty(ConnectionConfiguration.imqAddressList,"mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination ex3=context.createTopic("Ex_3d");
            TextMessage outMsg=context.createTextMessage();
            outMsg.setText("I'm exhausted");
            outMsg.setStringProperty("symbol","BelSTU");
            JMSProducer prod=context.createProducer().send(ex3,outMsg);
        }
        catch(Exception e){
            System.out.println(e.getMessage());
        }
    }
}
