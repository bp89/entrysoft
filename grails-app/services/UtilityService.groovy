

import com.softiv.entrysoft.core.Role
import com.softiv.entrysoft.core.User
import grails.plugin.mail.MailService
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap
import org.codehaus.groovy.grails.web.util.WebUtils
import org.springframework.web.multipart.commons.CommonsMultipartFile

@Transactional
class UtilityService {
    def grailsApplication
    MailService mailService
    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService

    def serviceMethod() {

    }

    /**
     *
     * @param string
     * @return
     */
    Boolean isValidString(String string){
        string==null  || string == 'null' || string.trim() =='' ?false:true;
    }

    /**
     *
     * @param params
     * @param fileBytes
     * @return
     */
    Boolean uploadFile(GrailsParameterMap params,def fileBytes){
        int size = 0;
        println ">>>>>>>>>>>>>>>>>>>>>>"+params.topic
        String buildDocs = grailsApplication.config.builddocs
        CommonsMultipartFile uploadedFile = params.file
        String contentType =  "";
        String fileName = "";
        if(uploadedFile){
            contentType =  uploadedFile.contentType
            fileName = uploadedFile.originalFilename
//           size = uploadedFile.size
            params.fileType = contentType
            params.fileName = fileName
        }
        println "============="+buildDocs+params.topic.id+"/"+ fileName
        if (!fileBytes?.empty ) {
            try{
                File file = new File(buildDocs+params.topic.id+"/"+ fileName)
                file.mkdirs()
                fileBytes.transferTo(file)
            }catch (Exception e){
                println "Exception while uploading file"
                return false;
            }
            return true
        }

    }



    /**
     *
     * @param sender
     * @param sendTo
     * @param mailCC
     * @param mailBcc
     * @param mailSubject
     * @param textOrHTML
     * @param isHTML
     * @return
     */
    def sendMail(String sender,List<String> sendTo,List<String> mailCC,List<String> mailBcc,String mailSubject,String textOrHTML,boolean isHTML){
        mailService.sendMail {
            from sender
            to sendTo
            subject mailSubject
            //cc mailCC
//            bcc mailBcc
            if(isHTML){
                html  textOrHTML
            }else{
                text "this is some text"
            }
        }

    }


    /**
     *
     * @param user
     * @param randomNumber
     * @return
     */
    StringBuilder getForgotPasswordHTML(User user,String randomNumber){
        def webUtils = WebUtils.retrieveGrailsWebRequest()
        String siteUrl = webUtils.getCurrentRequest().siteUrl
        StringBuilder html= new StringBuilder();
        html.append("<html>")
                .append("<body>")
                .append("To reset your password follow steps mentioned below:")
                .append("<ol>")
                .append("<li>")
                .append("<a href='").append(siteUrl).append("/user/resetPassword?confirmCode=").append(randomNumber).append("'>Click here to Reset your password ").append("</a>.")
                .append("</li>")
                .append("<li>")
                .append("Enter your new Password.")
                .append("</li>")
                .append("<li>")
                .append("Enter Confirmation password.")
                .append("</li>")
                .append("<li>")
                .append("You are done.Try logging in with new details.")
                .append("</li>")
                .append("</ol>")
                .append("</body")
                .append("</html>")
        return html

    }

    /**
     *
     * @param emailID
     * @return
     */
    User getUserOnEmailID(String emailID){
        return  User.createCriteria().get {
            eq("emailID",emailID)
        }
    }

//    /**
//     *
//     * @param user
//     * @param forgotPasswordCO
//     * @param confirmCode
//     * @return
//     */
//    def triggerForgotPasswordMail(User user,ForgotPasswordCO forgotPasswordCO,String confirmCode){
//        String subject = "Reset your password now."
//        sendMail('support@intelligrape.com', [forgotPasswordCO.emailID],null,null,subject,getForgotPasswordHTML(user,confirmCode).toString(),true)
//    }

    /**
     *
     * @return
     */
    def getCurrentUser(){
        springSecurityService.getCurrentUser()
    }

    /**
     *
     * @param ordinal
     * @return
     */
    public String getString(String ordinal){
        return getString(Integer.parseInt(ordinal));
    }
    /**
     *
     * @param ordinal
     * @return
     */
    public String getString(Integer ordinal){
        switch (ordinal){
            case 1: return "Very Low"
                break;
            case 2 : return "Low"
                break;
            case 3: return "Medium"
                break;
            case 4:return "High"
                break;
            default :return "Extreme"
                break;
        }
    }

    /**
     *
     * @param userID
     * @return
     */
    def getSubscribedToTopics(Long userID){
        return  UserSubscriptionDetails.createCriteria().list {
            projections{
                property('topic.id')
                property('seriousnessLevel','seriousnessLevel')
            }
            'eq'('user.id',userID)
        }
    }

    /**
     *
     * @param userID
     * @return
     */
    def getSubscribedToTopics(String userID){
        return getSubscribedToTopics(Long.parseLong(userID))

    }

    /**
     *
     * @return
     */
    def getPublicTopics(){
        return Topic.createCriteria().list {
            'eq'('visibility','Public')
        }
    }
    /**
     *
     */
    def fillPublicTopicDetails(){
        def webUtils = WebUtils.retrieveGrailsWebRequest()
        def request = webUtils.getCurrentRequest()
        User user = springSecurityService.getCurrentUser()
        List tempList =   getSubscribedToTopics(user.id)
        List subscribedTo = []
        Map <String,String> seriousnessLevel = [:];

        tempList.each {
            seriousnessLevel.put(it[0],it[1]);
            subscribedTo.add(it[0])
        }
        request.setAttribute('subscribedTo',subscribedTo)
        request.setAttribute('seriousnessLevel',seriousnessLevel)
    }

    def getOrCreateRole(name) {
        def role = Role.findByAuthority(name)
        if (!role) role = new Role(authority: name).save()
        if (!role)  println "Unable to save role ${name}"
        return role
    }
}
