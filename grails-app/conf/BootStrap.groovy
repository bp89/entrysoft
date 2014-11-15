import com.softiv.entrysoft.core.User
import com.softiv.entrysoft.core.UserRole

class BootStrap {
    UtilityService utilityService
    def init = { servletContext ->

        User defaultUser = null;

        def userRole = utilityService.getOrCreateRole("ROLE_USER")
        def adminRole = utilityService.getOrCreateRole("ROLE_ADMIN")

        if(!User.findByUsername('admin')){//Fail-Safe insertion
            defaultUser = new User();
            defaultUser.username = 'admin'
            defaultUser.password = 'r1tew0rk'
            defaultUser.enabled=true
            defaultUser.errors.each {
                println "==========="+it
            }
            defaultUser.save flush:  true

            def rel = UserRole.create(defaultUser, userRole)
        }else{
            defaultUser=User.findByUsername('admin')
        }

    }
    def destroy = {
    }
}
