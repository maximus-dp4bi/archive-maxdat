import java.math.BigInteger;


public class ContactRecord {

    private String eventName;
    private String eventType;
    private String contactChannelType;
    private String createdBy;
    private String uiid;
    private String correlationId;
    private String contactRecordType;
    private String createdOn;
    private long contactRecordId;
    private double linkRefId;
    private boolean consumerAuthenticatedInd;
    private String linkRefType;

    @Override
    public String toString() {
        return eventName + " " + eventType + " " + contactChannelType + " " + createdBy + " " + uiid + " " + correlationId + " " + contactRecordType +
                " " + createdOn + " " + contactRecordId + "  " + linkRefId + " " + consumerAuthenticatedInd + " " + linkRefType;
    }



    public ContactRecord(){

    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getEventType() {
        return eventType;
    }

    public void setEventType(String eventType) {
        this.eventType = eventType;
    }

    public String getContactChannelType() {
        return contactChannelType;
    }

    public void setContactChannelType(String contactChannelType) {
        this.contactChannelType = contactChannelType;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getUiid() {
        return uiid;
    }

    public void setUiid(String uiid) {
        this.uiid = uiid;
    }

    public String getCorrelationId() {
        return correlationId;
    }

    public void setCorrelationId(String correlationId) {
        this.correlationId = correlationId;
    }

    public String getContactRecordType() {
        return contactRecordType;
    }

    public void setContactRecordType(String contactRecordType) {
        this.contactRecordType = contactRecordType;
    }

    public String getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(String createdOn) {
        this.createdOn = createdOn;
    }

    public long getContactRecordId() {
        return contactRecordId;
    }

    public void setContactRecordId(long contactRecordId) {
        this.contactRecordId = contactRecordId;
    }

    public double getLinkRefId() {
        return linkRefId;
    }

    public void setLinkRefId(double linkRefId) {
        this.linkRefId = linkRefId;
    }

    public boolean getConsumerAuthenticatedInd() {
        return consumerAuthenticatedInd;
    }

    public void setConsumerAuthenticatedInd(boolean consumerAuthenticatedInd) {
        this.consumerAuthenticatedInd = consumerAuthenticatedInd;
    }

    public String getLinkRefType() {
        return linkRefType;
    }

    public void setLinkRefType(String linkRefType) {
        this.linkRefType = linkRefType;
    }
}
