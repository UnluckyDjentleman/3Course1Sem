package lab.pubsub.taskB;

import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;

import javax.jms.Destination;
import javax.jms.JMSContext;

public class Sender1 {
    public static void main(String[] args) {
        ConnectionFactory cf=new ConnectionFactory();
        try(JMSContext context= cf.createContext("admin","admin")){
            cf.setProperty(ConnectionConfiguration.imqAddressList,"mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination ex3=context.createTopic("Ex_3b");
            while(true){
                context.createProducer().setPriority(0).send(ex3,"Priority 0");
                System.out.println("Message has been sent with priority 0...");
                Thread.sleep(1000);
            }
        }
        catch(Exception e){
            System.out.println(e.getMessage());
        }
    }
}
