package ouhk.webProject.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import ouhk.webProject.model.UserRole;

public interface UserRoleRepository extends JpaRepository<UserRole, Integer> {
}
