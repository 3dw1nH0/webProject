package ouhk.webProject.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import ouhk.webProject.model.Ticket;

public interface TicketRepository extends JpaRepository<Ticket, Long> {
}
