package ouhk.webProject.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.Date;
import java.util.List;
import static javassist.CtMethod.ConstParameter.string;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import ouhk.webProject.dao.BidUserRepository;
import ouhk.webProject.dao.GuestbookRepository;
import ouhk.webProject.exception.AttachmentNotFound;
import ouhk.webProject.exception.TicketNotFound;
import ouhk.webProject.model.Attachment;
import ouhk.webProject.model.Guestbook;
import ouhk.webProject.model.Ticket;
import ouhk.webProject.model.bidUser;
import ouhk.webProject.view.DownloadingView;
import ouhk.webProject.service.AttachmentService;
import ouhk.webProject.service.TicketService;

@Controller
@RequestMapping("ticket")
public class TicketController {

    @Autowired
    private TicketService ticketService;

    @Autowired
    private AttachmentService attachmentService;

    @Resource
    private GuestbookRepository guestbookRepo;

    @Resource
    private BidUserRepository bidUserEntryRepo;

    @RequestMapping(value = {"", "list"}, method = RequestMethod.GET)
    public String list(ModelMap model) {
        model.addAttribute("ticketDatabase", ticketService.getTickets());
        return "list";
    }

    public static class Form {

        private String userName;
        private String description, price, status, winner;
        private List<MultipartFile> attachments;

        public String getUserName() {
            return userName;
        }

        public String getStatus() {
            return status;
        }

        public String getWinner() {
            return winner;
        }

        public String getDescription() {
            return description;
        }

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setUserName(String userName) {
            this.userName = userName;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public void setWinner(String winner) {
            this.winner = winner;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

    }

    @RequestMapping(value = "create", method = RequestMethod.GET)
    public ModelAndView bidForm(ModelMap model, Principal principal) {
        model.addAttribute("owner", principal.getName());
        return new ModelAndView("addBidding", "bidForm", new Form());
    }

    @RequestMapping(value = "create", method = RequestMethod.POST)
    public String bidForm(Form form, Principal principal) throws IOException {

        long ticketId = ticketService.createTicket(principal.getName(), form.getDescription(),
                form.getPrice(), form.getStatus(), form.getWinner(),
                form.getAttachments());

        return "redirect:/ticket/view/" + ticketId;
    }

    @RequestMapping(value = "view/{ticketId}", method = RequestMethod.GET)
    public String view(@PathVariable("ticketId") long ticketId,
            ModelMap model) {
        Ticket ticket = ticketService.getTicket(ticketId);
        if (ticket == null) {
            return "redirect:/ticket/list";
        }
        model.addAttribute("ticket", ticket);
        model.addAttribute("bids", bidUserEntryRepo.findAll());
        model.addAttribute("guestBooks",guestbookRepo.findAll());
        return "view";
    }

    @RequestMapping(
            value = "/{ticketId}/attachment/{attachment:.+}",
            method = RequestMethod.GET
    )
    public View download(@PathVariable("ticketId") long ticketId,
            @PathVariable("attachment") String name) {

        Attachment attachment = attachmentService.getAttachment(ticketId, name);
        if (attachment != null) {
            return new DownloadingView(attachment.getName(),
                    attachment.getMimeContentType(), attachment.getContents());
        }
        return new RedirectView("/ticket/list", true);
    }

    @RequestMapping(value = "delete/{ticketId}", method = RequestMethod.GET)
    public String deleteTicket(@PathVariable("ticketId") long ticketId)
            throws TicketNotFound {
        ticketService.delete(ticketId);
        return "redirect:/ticket/list";
    }

    @RequestMapping(value = "edit/{ticketId}", method = RequestMethod.GET)
    public ModelAndView showEdit(@PathVariable("ticketId") long ticketId,
            Principal principal, HttpServletRequest request) {
        Ticket ticket = ticketService.getTicket(ticketId);
        if (ticket == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(ticket.getUserName()))) {
            return new ModelAndView(new RedirectView("/ticket/list", true));
        }

        ModelAndView modelAndView = new ModelAndView("edit");
        modelAndView.addObject("ticket", ticket);

        Form bidForm = new Form();
        bidForm.setUserName(ticket.getUserName());
        bidForm.setDescription(ticket.getDescription());
        bidForm.setPrice(ticket.getPrice());
        bidForm.setStatus(ticket.getStatus());
        bidForm.setWinner(ticket.getWinner());
        modelAndView.addObject("bidForm", bidForm);

        return modelAndView;
    }

    @RequestMapping(value = "edit/{ticketId}", method = RequestMethod.POST)
    public View edit(@PathVariable("ticketId") long ticketId, Form form,
            Principal principal, HttpServletRequest request)
            throws IOException, TicketNotFound {
        Ticket ticket = ticketService.getTicket(ticketId);
        if (ticket == null
                || (!request.isUserInRole("ROLE_ADMIN")
                && !principal.getName().equals(ticket.getUserName()))) {
            return new RedirectView("/ticket/list", true);
        }

        ticketService.updateTicket(ticketId, form.getDescription(), form.getPrice(), form.getStatus(), form.getWinner(),
                form.getAttachments());
        return new RedirectView("/ticket/view/" + ticketId, true);
    }

    @RequestMapping(
            value = "/{ticketId}/delete/{attachment:.+}",
            method = RequestMethod.GET
    )
    public String deleteAttachment(@PathVariable("ticketId") long ticketId,
            @PathVariable("attachment") String name) throws AttachmentNotFound {
        ticketService.deleteAttachment(ticketId, name);
        return "redirect:/ticket/edit/" + ticketId;
    }

    @RequestMapping(value = "view/{ticketId}/bid", method = RequestMethod.GET)
    public ModelAndView bid(@PathVariable("ticketId") long ticketId, ModelMap model, Principal principal) {
        bidUser bid = new bidUser();
        return new ModelAndView("bid", "bidForm", bid);
    }

    @RequestMapping(value = "view/{ticketId}/bid", method = RequestMethod.POST)
    public View bid(@PathVariable("ticketId") long ticketId, bidUser bid, Principal principal) {
        bid.setItemID(ticketId);
        bid.setUsername(principal.getName());
        bidUserEntryRepo.save(bid);
        return new RedirectView("/ticket/view/" + ticketId, true);
    }

    @RequestMapping(value = "view/{ticketId}/guestbook", method = RequestMethod.GET)
    public ModelAndView guestbook(@PathVariable("ticketId") long ticketId, ModelMap model, Principal principal) {
        Guestbook gbook = new Guestbook();
        return new ModelAndView("guestBook", "guestBookForm", gbook);
    }

    @RequestMapping(value = "view/{ticketId}/guestbook", method = RequestMethod.POST)
    public View guestbook(@PathVariable("ticketId") long ticketId, Guestbook gbook, Principal principal) {
        gbook.setItemID(ticketId);
        gbook.setName(principal.getName());
        Date date = new Date();
        gbook.setDate(date);
        guestbookRepo.save(gbook);
        return new RedirectView("/ticket/view/" + ticketId, true);
    }

}
