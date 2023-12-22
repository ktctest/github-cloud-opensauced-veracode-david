<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
        <iframe name="dummy-frame" id="dummy-frame" style="display: none;"></iframe>

        <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post" target="dummy-frame">
            <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                   readonly="readonly" style="display:none;"/>
            <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

            <div style="display:none;">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-new" class="${properties.kcLabelClass!}">${msg("passwordNew")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password-new" name="password-new" class="${properties.kcInputClass!}"
                           autofocus autocomplete="new-password"
                           aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                    />
                </div>
            </div>

            <div style="display:none;">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="password" id="password-confirm" name="password-confirm"
                           class="${properties.kcInputClass!}"
                           autocomplete="new-password"
                           aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                    />
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcLabelWrapperClass!}">
                    <label for="license-key" class="${properties.kcLabelClass!}">Lizenzschlüssel</label>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <textarea id="license-key" class="form-control" style="height: 160px; resize: none;"></textarea>
                    <script>
                        const generatePassword = () => {
                            const length = 256;
                            const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
                            let retVal = '';
                            for (let i = 0, n = charset.length; i < length; ++i) {
                                retVal += charset.charAt(Math.floor(Math.random() * n));
                            }
                            return retVal;
                        }

                        // The relevant elements used for the update of the password.
                        const licenceKeyUserInput = document.getElementById('username');
                        const passwordNewInput = document.getElementById('password-new');
                        const passwordConfirmInput = document.getElementById('password-confirm');
                        const licenceKeyTextarea = document.getElementById('license-key');

                        // Generates a new key by combining the username and a random generated password
                        // separated by a ':'.
                        // Afterward the key will be base64 encoded.
                        const licenceKeyUsr = licenceKeyUserInput.value;
                        const licenceKeyPwd = generatePassword();
                        const licenceKeyTxt = btoa(licenceKeyUsr + ':' + licenceKeyPwd);

                        // Inserts the generated password to the password fields used
                        // by the form. This simulates the native behaviour of this page.
                        passwordNewInput.value = licenceKeyPwd;
                        passwordConfirmInput.value = licenceKeyPwd;
                        // Inserts the licence key to the textarea that is shown to
                        // the user.
                        licenceKeyTextarea.value = licenceKeyTxt;

                        // The licence key is selected by default when entering this page.
                        licenceKeyTextarea.focus();
                        licenceKeyTextarea.select();

                        // Submits the password change.
                        // Note: the redirect after the submission is redirected to a dummy iFrame.
                        document.forms['kc-passwd-update-form'].submit();
                    </script>
                </div>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <input style="display: none;"
                       class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                       type="submit" value="${msg("doSubmit")}"/>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>