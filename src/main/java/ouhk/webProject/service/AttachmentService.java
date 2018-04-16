package ouhk.webProject.service;

import ouhk.webProject.model.Attachment;

public interface AttachmentService {

    public Attachment getAttachment(long ticketId, String name);
}
