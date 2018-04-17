package ouhk.webProject.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import ouhk.webProject.model.Guestbook;

public interface GuestbookRepository extends JpaRepository<Guestbook, Integer> {

}
