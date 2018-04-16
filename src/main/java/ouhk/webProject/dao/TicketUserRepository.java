package ouhk.webProject.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import ouhk.webProject.model.TicketUser;

public interface TicketUserRepository extends JpaRepository<TicketUser, String> {
}
