package lab.p2p.sync;

import com.sun.messaging.ConnectionConfiguration;
import com.sun.messaging.ConnectionFactory;
import lab.p2p.Prospect;

import javax.jms.*;

public class Sender {
    public static void main(String[] args) {
        ConnectionFactory cf = new ConnectionFactory();

        try(JMSContext jmsContext=cf.createContext("admin","admin")){
            cf.setProperty(ConnectionConfiguration.imqAddressList,"mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination dest=jmsContext.createQueue("Ex2_SYNC");
            Prospect prosp1=new Prospect(2,9,"Artyom Levshunov","Defenceman","Belarus","A");
            ObjectMessage objMes= jmsContext.createObjectMessage(prosp1);
            JMSProducer jmsProducer= jmsContext.createProducer();
            jmsProducer.send(dest,objMes);
            System.out.println("Message has been sent...");
        } catch (JMSException e) {
            throw new RuntimeException(e);
        }
    }
}
