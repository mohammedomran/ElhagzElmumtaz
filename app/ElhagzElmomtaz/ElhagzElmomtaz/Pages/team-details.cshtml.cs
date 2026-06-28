using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class TeamDetailsModel : PageModel
{
    private readonly ILogger<TeamDetailsModel> _logger;

    public TeamDetailsModel(ILogger<TeamDetailsModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
