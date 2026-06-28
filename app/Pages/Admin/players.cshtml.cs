using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages.Admin;

public class PlayersModel : PageModel
{
    public List<PlayerRow> Players { get; set; } = new();

    public void OnGet()
    {
        Players = new()
        {
            new(1, "Ahmed Hassan", "El Captain", "Cairo", "Professional", true, "2025-01-12"),
            new(2, "Mohamed Salah", "Mido", "Giza", "Advanced", true, "2025-02-03"),
            new(3, "Omar Khaled", null, "Alexandria", "Intermediate", false, "2025-02-21"),
            new(4, "Youssef Adel", "Joe", "Cairo", "Beginner", false, "2025-03-09"),
            new(5, "Karim Fathy", "KK", "Mansoura", "Advanced", true, "2025-03-18"),
        };
    }

    public record PlayerRow(
        int Id,
        string FullName,
        string? Nickname,
        string City,
        string SkillLevel,
        bool IsVerified,
        string CreatedAt);
}
