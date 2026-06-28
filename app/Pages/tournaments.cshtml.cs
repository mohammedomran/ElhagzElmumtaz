using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ElhagzElmomtaz.Pages;

public class TournamentsModel : PageModel
{
    private readonly ILogger<TournamentsModel> _logger;

    public TournamentsModel(ILogger<TournamentsModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}
