package ouhk.webProject.service;

import java.io.IOException;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import ouhk.webProject.exception.AttachmentNotFound;
import ouhk.webProject.exception.TicketNotFound;
import ouhk.webProject.model.Ticket;

public interface TicketService {

    public long createTicket(String userName, String description, 
            String price, String status, String winner, List<MultipartFile> attachments) throws IOException;

    public List<Ticket> getTickets();

    public Ticket getTicket(long id);

    public void updateTicket(long id, String description,
            String price, String status, String winner, List<MultipartFile> attachments)
            throws IOException, TicketNotFound;

    public void delete(long id) throws TicketNotFound;

    public void deleteAttachment(long ticketId, String name)
            throws AttachmentNotFound;
}
