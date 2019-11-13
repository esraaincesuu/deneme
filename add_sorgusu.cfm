<cfset dsn='dsn'>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<cfset upload_folder = "C:\inetpub\wwwroot\images\">
<cfquery name="upd_" datasource="#dsn#" result="max_id">
	INSERT INTO
		FOTOLAR
	(
    	FOTO_AD
	
    )
    VALUES
    (
    	'#form.foto_ad#'
    )

</cfquery>
	<cfset max_id = max_id.identitycol>

<cfif isdefined("form.photo") and LEN(Trim(form.photo))>
	<cftry>
		<cffile
			action="UPLOAD" 
			filefield="photo" 
			destination="#upload_folder#" 
			mode="777" 
			nameconflict="MAKEUNIQUE"
			>
			
		<cfset file_name = 'foto_#max_id#'>
		<cffile action="rename" source="#upload_folder##cffile.serverfile#" destination="#upload_folder##file_name#.#cffile.serverfileext#">
		<cfset aaa = '#file_name#.#cffile.serverfileext#'>
			
		<cfcatch type="Any">
			<script type="text/javascript">
				alert("Dosya Yükleme Sorunu!");
				history.back();
			</script>
			<cfabort>
		</cfcatch>  
	</cftry>
	
	<cfquery name="Upd_Photo" datasource="#dsn#">
		UPDATE FOTOLAR SET foto = '#aaa#' WHERE FOTO_ID = #max_id#
	</cfquery>
</cfif>

		<script type="text/javascript">
		swal("Kaydedildi");
		window.location.href='<cfoutput>fotosec.cfm?dil=#form.dil#</cfoutput>';
		
		</script>

