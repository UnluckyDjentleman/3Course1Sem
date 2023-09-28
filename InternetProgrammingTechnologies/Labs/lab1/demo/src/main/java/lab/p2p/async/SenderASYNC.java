package lab.p2p.async;

import javax.jms.*;
import com.sun.messaging.ConnectionFactory;
import com.sun.messaging.ConnectionConfiguration;
import lab.p2p.Prospect;
public class SenderASYNC{
    public static void main(String[] args) {
        ConnectionFactory cf = new ConnectionFactory();

        try(JMSContext jmsContext=cf.createContext("admin","admin")){
            cf.setProperty(ConnectionConfiguration.imqAddressList,"mq://127.0.0.1:7676,mq://127.0.0.1:7676");
            Destination dest=jmsContext.createQueue("Ex2_ASYNC");
            Prospect prosp1=new Prospect(3,85,"Ty Young","Goalkeeper","Canada","B");
            ObjectMessage objMes= jmsContext.createObjectMessage(prosp1);
            JMSProducer jmsProducer= jmsContext.createProducer();
            jmsProducer.send(dest,objMes);
            System.out.println("Message has been sent...");
        } catch (JMSException e) {
            throw new RuntimeException(e);
        }
    }
}
