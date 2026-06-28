using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages.Admin;

public class NotificationsModel : PageModel
{
    public List<NotificationRow> Notifications { get; set; } = new();

    public void OnGet()
    {
        Notifications = new()
        {
            new(1, "Friday League starts soon", "Round 1 kicks off this Friday at 8 PM. Be ready!", "2025-06-25"),
            new(2, "New stadium added", "Alex Beach Pitch is now available for friendly matches.", "2025-06-20"),
            new(3, "Maintenance notice", "The app will be briefly unavailable on Saturday morning.", "2025-06-18"),
        };
    }

    public record NotificationRow(int Id, string Title, string Body, string CreatedAt);
}
