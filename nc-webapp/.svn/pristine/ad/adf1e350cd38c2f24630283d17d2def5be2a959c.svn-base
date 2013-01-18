<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>


<stripes:layout-definition>
    <nc:pageName pageName="${pageName}"/>
    <nc:pageViewMode readOnly="${actionBean.showAsReadOnly eq true}"/>
    
    <ul id="tmcaInfo-capacityInfoSection" class="column-style-fieldset threeCols">
        <nc:ifAccessAllowed name="location.showroomCapacityInfo">
            <li>
            <!-- ====   Start Showroom Capacity Information ========================================= -->
            <fieldset id="tmcaInfo-capacitySection-showroom">
                <legend><fmt:message key="location.tmcatab.section.capacity.showroom.header"/></legend>
                <nc:label name="location.showroomCapacityInfo.area" for="location.showroomCapacityInfo.area"/>
                <nc:text id="location.showroomCapacityInfo.area" name="location.showroomCapacityInfo.area"/><br/>

                <nc:label name="location.showroomCapacityInfo.displayVehicles" for="location.showroomCapacityInfo.displayVehicles"/>
                <nc:text id="location.showroomCapacityInfo.displayVehicles" name="location.showroomCapacityInfo.displayVehicles"/><br/>
            </fieldset>
            <!-- ====   End Showroom Capacity Information ========================================= -->
            </li>
        </nc:ifAccessAllowed>

        <nc:ifAccessAllowed name="location.newVehicleCapacityInfo">
            <li>
            <!-- ====   Start New Vehicle Capacity Information ========================================= -->
            <fieldset id="tmcaInfo-capacitySection-vehicles-new">
                <legend><fmt:message key="location.tmcatab.section.capacity.vehicles.new.header"/></legend>
                <nc:label name="location.newVehicleCapacityInfo.customerParking" for="location.newVehicleCapacityInfo.customerParking"/>
                <nc:text id="location.newVehicleCapacityInfo.customerParking" name="location.newVehicleCapacityInfo.customerParking"/><br/>

                <nc:label name="location.newVehicleCapacityInfo.demonstratorParking" for="location.newVehicleCapacityInfo.demonstratorParking"/>
                <nc:text id="location.newVehicleCapacityInfo.demonstratorParking" name="location.newVehicleCapacityInfo.demonstratorParking"/><br/>

                <nc:label name="location.newVehicleCapacityInfo.undercoverBay" for="location.newVehicleCapacityInfo.undercoverBay"/>
                <nc:text id="location.newVehicleCapacityInfo.undercoverBay" name="location.newVehicleCapacityInfo.undercoverBay"/><br/>

                <nc:label name="location.newVehicleCapacityInfo.externalDisplaySpaces" for="location.newVehicleCapacityInfo.externalDisplaySpaces"/>
                <nc:text id="location.newVehicleCapacityInfo.externalDisplaySpaces" name="location.newVehicleCapacityInfo.externalDisplaySpaces"/><br/>

                <nc:label name="location.newVehicleCapacityInfo.storageArea" for="location.newVehicleCapacityInfo.storageArea"/>
                <nc:text id="location.newVehicleCapacityInfo.storageArea" name="location.newVehicleCapacityInfo.storageArea"/><br/>
            </fieldset>
            <!-- ====   End New Vehicle Capacity Information ========================================= -->
            </li>
        </nc:ifAccessAllowed>


     <nc:ifAccessAllowed name="location.usedVehicleCapacityInfo">
         <li>
         <!-- ====   Start Used Vehicle Capacity Information ========================================= -->
        <fieldset id="tmcaInfo-capacitySection-vehicles-used">
            <legend><fmt:message key="location.tmcatab.section.capacity.vehicles.used.header"/></legend>

            <nc:label name="location.usedVehicleCapacityInfo.storageArea" for="location.usedVehicleCapacityInfo.storageArea"/>
            <nc:text id="location.usedVehicleCapacityInfo.storageArea" name="location.usedVehicleCapacityInfo.storageArea"/><br/>

            <nc:label name="location.usedVehicleCapacityInfo.externalDisplaySpaces" for="location.usedVehicleCapacityInfo.externalDisplaySpaces"/>
            <nc:text id="location.usedVehicleCapacityInfo.externalDisplaySpaces" name="location.usedVehicleCapacityInfo.externalDisplaySpaces"/><br/>

            <nc:label name="location.usedVehicleCapacityInfo.customerParking" for="location.usedVehicleCapacityInfo.customerParking"/>
            <nc:text id="location.usedVehicleCapacityInfo.customerParking" name="location.usedVehicleCapacityInfo.customerParking"/><br/>
        </fieldset>
        <!-- =============   End Used Vehicle Capacity Information ===================================== -->
         </li>
    </nc:ifAccessAllowed>
    </ul>
</stripes:layout-definition>
