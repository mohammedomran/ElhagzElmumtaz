using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages.Admin;

public class MatchesModel : PageModel
{
    public List<MatchRow> Matches { get; set; } = new();

    public void OnGet()
    {
        Matches = new()
        {
            new(1, "Fifth Settlement Arena", "2025-07-04", "20:00", "22:00"),
            new(2, "Giza Sports Hub", "2025-07-11", "18:00", "20:00"),
            new(3, "Alex Beach Pitch", "2025-07-18", "21:00", "23:00"),
        };
    }

    public record MatchRow(int Id, string Stadium, string ScheduledDate, string FromTime, string ToTime);
}
