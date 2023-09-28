package lab.task04;

import com.sun.messaging.ConnectionFactory;
import com.sun.messaging.ConnectionConfiguration;
import javax.jms.*;

import jakarta.jms.JMSException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "SenderServlet", value = "/SenderServlet")
public class SenderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ConnectionFactory cf=new ConnectionFactory();
        try (JMSContext context = cf.createContext("admin", "admin")){
            cf.setProperty(ConnectionConfiguration.imqAddressList, "mq://127.0.0.1:7676, mq://127.0.0.1:7676");

            Destination cardsQueue = context.createQueue("Servlet");
            JMSProducer producer = context.createProducer();

            producer.send(cardsQueue,req.getParameter("message"));

            System.out.println("Placed info...");
        }
        catch (Exception err) {
            System.out.println(err.getMessage());
        }

        resp.sendRedirect("");
    }
}
