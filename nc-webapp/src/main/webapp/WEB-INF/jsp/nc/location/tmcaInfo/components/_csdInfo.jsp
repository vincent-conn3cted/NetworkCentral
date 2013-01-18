<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    

    <nc:ifAccessAllowed name="location.csdInfo">
        <fieldset>
            <legend class="legend">CSD</legend>
            <ul id="tmcaInfo-csdInfoSection" class="column-style-fieldset threeCols">
              <!-- ========= Start CSD Information ========================================= -->
            <li>
                <fieldset id="tmcaInfo-csdInfoSection-tsm1">
                    <nc:label name="location.csdInfo.tsmLevel1" for="location.csdInfo.tsmLevel1"/>
                    <nc:checkbox id="location.csdInfo.tsmLevel1" name="location.csdInfo.tsmLevel1"/><br/>

                    <nc:label name="location.csdInfo.level1Status" for="location.csdInfo.level1Status"/>
                    <nc:select name="location.csdInfo.level1Status" readOnlyValue="${actionBean.location.csdInfo.level1Status.description}">
                            <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.ProgramStatus" label="description"/>
                    </nc:select><br/>

                    <nc:label name="location.csdInfo.level1CertificationDate" for="location.csdInfo.level1CertificationDate"/>
                    <nc:datetext  id="location.csdInfo.level1CertificationDate" name="location.csdInfo.level1CertificationDate" class="dateField" buttonId="level1CertificationDateTrigger" showTime="false"/><br/>

                    <nc:label name="location.csdInfo.level1RecertDate" for="location.csdInfo.level1RecertDate"/>
                    <nc:datetext  id="location.csdInfo.level1RecertDate" name="location.csdInfo.level1RecertDate" class="dateField" buttonId="level1RecertDateTrigger" showTime="false"/><br/>
                </fieldset>
            </li>
            <li>
                <fieldset id="tmcaInfo-csdInfoSection-tsm2">
                    <nc:label name="location.csdInfo.tsmLevel2" for="location.csdInfo.tsmLevel2"/>
                     <nc:checkbox id="location.csdInfo.tsmLevel2" name="location.csdInfo.tsmLevel2"/><br/>

                    <nc:label name="location.csdInfo.level2Status" for="location.csdInfo.level2Status"/>
                    <nc:select name="location.csdInfo.level2Status" readOnlyValue="${actionBean.location.csdInfo.level2Status.description}">
                            <stripes:option value=""><fmt:message key="label.selectone"/></stripes:option>
                            <stripes:options-enumeration enum="au.com.toyota.nc.common.model.hibernate.ProgramStatus" label="description"/>
                    </nc:select><br/>

                    <nc:label name="location.csdInfo.level2CertificationDate" for="location.csdInfo.level2CertificationDate"/>
                    <nc:datetext  id="location.csdInfo.level2CertificationDate" name="location.csdInfo.level2CertificationDate" class="dateField" buttonId="level2CertificationDateTrigger" showTime="false"/><br/>

                    <nc:label name="location.csdInfo.level2RecertDate" for="location.csdInfo.level2RecertDate"/>
                    <nc:datetext  id="location.csdInfo.level2RecertDate" name="location.csdInfo.level2RecertDate" class="dateField" buttonId="level2RecertDateTrigger" showTime="false"/><br/>
                </fieldset>
             </li>
            <li>
                <fieldset id="tmcaInfo-csdInfoSection-misc">
                    <nc:label name="location.csdInfo.expressMaintenanceFlag" for="location.csdInfo.expressMaintenanceFlag"/>
                    <nc:checkbox id="location.csdInfo.expressMaintenanceFlag" name="location.csdInfo.expressMaintenanceFlag"/><br/>

                    <nc:label name="location.csdInfo.tyreBatteryProgramFlag" for="location.csdInfo.tyreBatteryProgramFlag"/>
                    <nc:checkbox id="location.csdInfo.tyreBatteryProgramFlag" name="location.csdInfo.tyreBatteryProgramFlag"/><br/>

                    <nc:label name="location.csdInfo.bodyPaintRepairerFlag" for="location.csdInfo.bodyPaintRepairerFlag"/>
                    <nc:checkbox id="location.csdInfo.bodyPaintRepairerFlag" name="location.csdInfo.bodyPaintRepairerFlag"/><br/>

                    <nc:label name="location.csdInfo.bodyPaintTSMFlag" for="location.csdInfo.bodyPaintTSMFlag"/>
                    <nc:checkbox id="location.csdInfo.bodyPaintTSMFlag" name="location.csdInfo.bodyPaintTSMFlag"/><br/>
                </fieldset>
            </li>
              <!-- ======== End CSD Information ======================================= -->
            </ul>
        </fieldset>
    </nc:ifAccessAllowed>

</stripes:layout-definition>
