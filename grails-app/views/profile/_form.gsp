<%@ page import="com.softiv.entrysoft.core.Profile" %>



<div class="fieldcontain ${hasErrors(bean: profileInstance, field: 'resumePath', 'error')} required">
	<label for="resumePath">
		<g:message code="profile.resumePath.label" default="Resume Path" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="resumePath" required="" value="${profileInstance?.resumePath}"/>

</div>

