package ouhk.webProject.controller;

import java.io.IOException;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import ouhk.webProject.dao.TicketUserRepository;
import ouhk.webProject.model.TicketUser;

/**
 *
 * @author Edwin
 */
@Controller
@RequestMapping("register")
public class registerController {

    @Resource
    TicketUserRepository ticketUserRepo;

    public static class Form {

        private String username;
        private String password;
        private String[] roles;

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String[] getRoles() {
            return roles;
        }

        public void setRoles(String[] roles) {
            this.roles = roles;
        }

    }
    
     @RequestMapping(value = "", method = RequestMethod.GET)
    public ModelAndView register() {
        return new ModelAndView("register", "register", new Form());
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public View register(Form form) throws IOException {
        TicketUser user = new TicketUser(form.getUsername(),
                form.getPassword(),
                form.getRoles()
        );
        ticketUserRepo.save(user);
        return new RedirectView("/login", true);
    }

}
