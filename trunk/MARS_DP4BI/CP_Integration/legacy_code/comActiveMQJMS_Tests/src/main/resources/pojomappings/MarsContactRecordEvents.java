package pojomappings;

import java.sql.Time;
import java.util.Objects;

public class MarsContactRecordEvents {
    private Integer id;
    private Long contactRecordId;
    private String contactRecordType;
    private String consumerType;
    private String preferredLanguageCode;
    private Time contactRecordStartTime;
    private Time contactRecordEndTime;
    private String consumerPhone;
    private String consumerFirstName;
    private String consumerLastName;
    private String consumerEmail;
    private String contactRecordStatusType;
    private Byte consumerAuthenticatedInd;
    private String createdBy;
    private Time createdOn;
    private String updatedBy;
    private Time updatedOn;
    private String genericField1Txt;
    private String genericField2Txt;
    private String genericField3Txt;
    private String genericField4Txt;
    private Long genericField1Num;
    private Long genericField2Num;
    private Long genericField3Num;
    private Long genericField4Num;
    private Time genericField1Date;
    private Time genericField2Date;
    private Time genericField3Date;
    private Time genericField4Date;
    private Long linkRefId;
    private String linkRefType;
    private String correlationId;
    private String uiid;
    private Time wrapUpTime;
    private Integer callDuration;
    private String inboundCallQueue;
    private String contactChannelType;
    private String contactCompaignType;
    private String contactReasonEditType;
    private String contactOutcome;
    private String organizationName;
    private String contactType;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Long getContactRecordId() {
        return contactRecordId;
    }

    public void setContactRecordId(Long contactRecordId) {
        this.contactRecordId = contactRecordId;
    }

    public String getContactRecordType() {
        return contactRecordType;
    }

    public void setContactRecordType(String contactRecordType) {
        this.contactRecordType = contactRecordType;
    }

    public String getConsumerType() {
        return consumerType;
    }

    public void setConsumerType(String consumerType) {
        this.consumerType = consumerType;
    }

    public String getPreferredLanguageCode() {
        return preferredLanguageCode;
    }

    public void setPreferredLanguageCode(String preferredLanguageCode) {
        this.preferredLanguageCode = preferredLanguageCode;
    }

    public Time getContactRecordStartTime() {
        return contactRecordStartTime;
    }

    public void setContactRecordStartTime(Time contactRecordStartTime) {
        this.contactRecordStartTime = contactRecordStartTime;
    }

    public Time getContactRecordEndTime() {
        return contactRecordEndTime;
    }

    public void setContactRecordEndTime(Time contactRecordEndTime) {
        this.contactRecordEndTime = contactRecordEndTime;
    }

    public String getConsumerPhone() {
        return consumerPhone;
    }

    public void setConsumerPhone(String consumerPhone) {
        this.consumerPhone = consumerPhone;
    }

    public String getConsumerFirstName() {
        return consumerFirstName;
    }

    public void setConsumerFirstName(String consumerFirstName) {
        this.consumerFirstName = consumerFirstName;
    }

    public String getConsumerLastName() {
        return consumerLastName;
    }

    public void setConsumerLastName(String consumerLastName) {
        this.consumerLastName = consumerLastName;
    }

    public String getConsumerEmail() {
        return consumerEmail;
    }

    public void setConsumerEmail(String consumerEmail) {
        this.consumerEmail = consumerEmail;
    }

    public String getContactRecordStatusType() {
        return contactRecordStatusType;
    }

    public void setContactRecordStatusType(String contactRecordStatusType) {
        this.contactRecordStatusType = contactRecordStatusType;
    }

    public Byte getConsumerAuthenticatedInd() {
        return consumerAuthenticatedInd;
    }

    public void setConsumerAuthenticatedInd(Byte consumerAuthenticatedInd) {
        this.consumerAuthenticatedInd = consumerAuthenticatedInd;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Time getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Time createdOn) {
        this.createdOn = createdOn;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Time getUpdatedOn() {
        return updatedOn;
    }

    public void setUpdatedOn(Time updatedOn) {
        this.updatedOn = updatedOn;
    }

    public String getGenericField1Txt() {
        return genericField1Txt;
    }

    public void setGenericField1Txt(String genericField1Txt) {
        this.genericField1Txt = genericField1Txt;
    }

    public String getGenericField2Txt() {
        return genericField2Txt;
    }

    public void setGenericField2Txt(String genericField2Txt) {
        this.genericField2Txt = genericField2Txt;
    }

    public String getGenericField3Txt() {
        return genericField3Txt;
    }

    public void setGenericField3Txt(String genericField3Txt) {
        this.genericField3Txt = genericField3Txt;
    }

    public String getGenericField4Txt() {
        return genericField4Txt;
    }

    public void setGenericField4Txt(String genericField4Txt) {
        this.genericField4Txt = genericField4Txt;
    }

    public Long getGenericField1Num() {
        return genericField1Num;
    }

    public void setGenericField1Num(Long genericField1Num) {
        this.genericField1Num = genericField1Num;
    }

    public Long getGenericField2Num() {
        return genericField2Num;
    }

    public void setGenericField2Num(Long genericField2Num) {
        this.genericField2Num = genericField2Num;
    }

    public Long getGenericField3Num() {
        return genericField3Num;
    }

    public void setGenericField3Num(Long genericField3Num) {
        this.genericField3Num = genericField3Num;
    }

    public Long getGenericField4Num() {
        return genericField4Num;
    }

    public void setGenericField4Num(Long genericField4Num) {
        this.genericField4Num = genericField4Num;
    }

    public Time getGenericField1Date() {
        return genericField1Date;
    }

    public void setGenericField1Date(Time genericField1Date) {
        this.genericField1Date = genericField1Date;
    }

    public Time getGenericField2Date() {
        return genericField2Date;
    }

    public void setGenericField2Date(Time genericField2Date) {
        this.genericField2Date = genericField2Date;
    }

    public Time getGenericField3Date() {
        return genericField3Date;
    }

    public void setGenericField3Date(Time genericField3Date) {
        this.genericField3Date = genericField3Date;
    }

    public Time getGenericField4Date() {
        return genericField4Date;
    }

    public void setGenericField4Date(Time genericField4Date) {
        this.genericField4Date = genericField4Date;
    }

    public Long getLinkRefId() {
        return linkRefId;
    }

    public void setLinkRefId(Long linkRefId) {
        this.linkRefId = linkRefId;
    }

    public String getLinkRefType() {
        return linkRefType;
    }

    public void setLinkRefType(String linkRefType) {
        this.linkRefType = linkRefType;
    }

    public String getCorrelationId() {
        return correlationId;
    }

    public void setCorrelationId(String correlationId) {
        this.correlationId = correlationId;
    }

    public String getUiid() {
        return uiid;
    }

    public void setUiid(String uiid) {
        this.uiid = uiid;
    }

    public Time getWrapUpTime() {
        return wrapUpTime;
    }

    public void setWrapUpTime(Time wrapUpTime) {
        this.wrapUpTime = wrapUpTime;
    }

    public Integer getCallDuration() {
        return callDuration;
    }

    public void setCallDuration(Integer callDuration) {
        this.callDuration = callDuration;
    }

    public String getInboundCallQueue() {
        return inboundCallQueue;
    }

    public void setInboundCallQueue(String inboundCallQueue) {
        this.inboundCallQueue = inboundCallQueue;
    }

    public String getContactChannelType() {
        return contactChannelType;
    }

    public void setContactChannelType(String contactChannelType) {
        this.contactChannelType = contactChannelType;
    }

    public String getContactCompaignType() {
        return contactCompaignType;
    }

    public void setContactCompaignType(String contactCompaignType) {
        this.contactCompaignType = contactCompaignType;
    }

    public String getContactReasonEditType() {
        return contactReasonEditType;
    }

    public void setContactReasonEditType(String contactReasonEditType) {
        this.contactReasonEditType = contactReasonEditType;
    }

    public String getContactOutcome() {
        return contactOutcome;
    }

    public void setContactOutcome(String contactOutcome) {
        this.contactOutcome = contactOutcome;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }

    public String getContactType() {
        return contactType;
    }

    public void setContactType(String contactType) {
        this.contactType = contactType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MarsContactRecordEvents that = (MarsContactRecordEvents) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(contactRecordId, that.contactRecordId) &&
                Objects.equals(contactRecordType, that.contactRecordType) &&
                Objects.equals(consumerType, that.consumerType) &&
                Objects.equals(preferredLanguageCode, that.preferredLanguageCode) &&
                Objects.equals(contactRecordStartTime, that.contactRecordStartTime) &&
                Objects.equals(contactRecordEndTime, that.contactRecordEndTime) &&
                Objects.equals(consumerPhone, that.consumerPhone) &&
                Objects.equals(consumerFirstName, that.consumerFirstName) &&
                Objects.equals(consumerLastName, that.consumerLastName) &&
                Objects.equals(consumerEmail, that.consumerEmail) &&
                Objects.equals(contactRecordStatusType, that.contactRecordStatusType) &&
                Objects.equals(consumerAuthenticatedInd, that.consumerAuthenticatedInd) &&
                Objects.equals(createdBy, that.createdBy) &&
                Objects.equals(createdOn, that.createdOn) &&
                Objects.equals(updatedBy, that.updatedBy) &&
                Objects.equals(updatedOn, that.updatedOn) &&
                Objects.equals(genericField1Txt, that.genericField1Txt) &&
                Objects.equals(genericField2Txt, that.genericField2Txt) &&
                Objects.equals(genericField3Txt, that.genericField3Txt) &&
                Objects.equals(genericField4Txt, that.genericField4Txt) &&
                Objects.equals(genericField1Num, that.genericField1Num) &&
                Objects.equals(genericField2Num, that.genericField2Num) &&
                Objects.equals(genericField3Num, that.genericField3Num) &&
                Objects.equals(genericField4Num, that.genericField4Num) &&
                Objects.equals(genericField1Date, that.genericField1Date) &&
                Objects.equals(genericField2Date, that.genericField2Date) &&
                Objects.equals(genericField3Date, that.genericField3Date) &&
                Objects.equals(genericField4Date, that.genericField4Date) &&
                Objects.equals(linkRefId, that.linkRefId) &&
                Objects.equals(linkRefType, that.linkRefType) &&
                Objects.equals(correlationId, that.correlationId) &&
                Objects.equals(uiid, that.uiid) &&
                Objects.equals(wrapUpTime, that.wrapUpTime) &&
                Objects.equals(callDuration, that.callDuration) &&
                Objects.equals(inboundCallQueue, that.inboundCallQueue) &&
                Objects.equals(contactChannelType, that.contactChannelType) &&
                Objects.equals(contactCompaignType, that.contactCompaignType) &&
                Objects.equals(contactReasonEditType, that.contactReasonEditType) &&
                Objects.equals(contactOutcome, that.contactOutcome) &&
                Objects.equals(organizationName, that.organizationName) &&
                Objects.equals(contactType, that.contactType);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, contactRecordId, contactRecordType, consumerType, preferredLanguageCode, contactRecordStartTime, contactRecordEndTime, consumerPhone, consumerFirstName, consumerLastName, consumerEmail, contactRecordStatusType, consumerAuthenticatedInd, createdBy, createdOn, updatedBy, updatedOn, genericField1Txt, genericField2Txt, genericField3Txt, genericField4Txt, genericField1Num, genericField2Num, genericField3Num, genericField4Num, genericField1Date, genericField2Date, genericField3Date, genericField4Date, linkRefId, linkRefType, correlationId, uiid, wrapUpTime, callDuration, inboundCallQueue, contactChannelType, contactCompaignType, contactReasonEditType, contactOutcome, organizationName, contactType);
    }
}
