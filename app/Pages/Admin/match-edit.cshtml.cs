using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages.Admin;

public class MatchEditModel : PageModel
{
    [BindProperty(SupportsGet = true)]
    public int Id { get; set; }

    public List<string> Stadiums { get; set; } = new();

    public string Stadium { get; set; } = "";
    public string ScheduledDate { get; set; } = "";
    public string FromTime { get; set; } = "";
    public string ToTime { get; set; } = "";

    public void OnGet()
    {
        Stadiums = new() { "Fifth Settlement Arena", "Giza Sports Hub", "Alex Beach Pitch" };

        // Mock: pretend we loaded the match by Id.
        Stadium = "Fifth Settlement Arena";
        ScheduledDate = "2025-07-04";
        FromTime = "20:00";
        ToTime = "22:00";
    }
}
