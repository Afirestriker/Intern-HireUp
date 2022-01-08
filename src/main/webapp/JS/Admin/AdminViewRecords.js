
/* Search Records Concept */
$(document).ready(function() {
    $("#searchField").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#tableBody tr").filter(function() {
            $(this).toggle($(this).text()
            .toLowerCase().indexOf(value) > -1)
        });
    });
});


/* Print only table content concept */
function printDiv() {
     window.frames["print_table"].document.body.innerHTML = document.getElementById("printableTable").innerHTML;
     window.frames["print_table"].window.focus();
     window.frames["print_table"].window.print();
   }
