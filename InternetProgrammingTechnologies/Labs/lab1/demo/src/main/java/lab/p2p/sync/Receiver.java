package lab.p2p.sync;

import javax.jms.*;
import com.sun.messaging.ConnectionFactory;
import com.sun.messaging.ConnectionConfiguration;
import lab.p2p.Prospect;

public class Receiver {
    ConnectionFactory cf = new ConnectionFactory();
    JMSConsumer consumer;
    Receiver(){
        try(JMSContext jmsContext=cf.createContext("admin","admin")){
            cf.setProperty(ConnectionConfiguration.imqAddressList,"mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination messageQueue = jmsContext.createQueue("Ex2_SYNC");
            consumer=jmsContext.createConsumer(messageQueue);
            Message mes=consumer.receive();
            System.out.println("Listening to Ex2_SYNC");
            System.out.println("Message:"+mes.getBody(Prospect.class));
            while(true){
                Thread.sleep(1000);
            }
        } catch (Exception e) {
            System.out.println("Error: "+e.getMessage());
        }
    }

    public static void main(String[] args) {
        new Receiver();
    }
}
