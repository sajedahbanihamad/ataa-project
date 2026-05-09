using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Ataa_Mobile_Application.DTOs;
using Ataa_Mobile_Application.Services.Interfaces;

namespace Ataa_Mobile_Application.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        private readonly ICategoryService _categoryService;
        public CategoriesController(ICategoryService categoryService) => _categoryService = categoryService;

        [AllowAnonymous]
        [HttpGet]
        public async Task<IActionResult> GetAll([FromQuery] bool includeInactive = false) => Ok(await _categoryService.GetAllAsync(includeInactive));

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id) => Ok(await _categoryService.GetByIdAsync(id));

        [Authorize(Roles = "Admin")]
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateCategoryDto dto) => Ok(await _categoryService.CreateAsync(dto));

        [Authorize(Roles = "Admin")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] UpdateCategoryDto dto)
        {
            var result = await _categoryService.UpdateAsync(id, dto);
            if (result == null)
                return NotFound(new { message = "Category not found." });
                
            return Ok(result);
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("{id}/active/{isActive}")]
        public async Task<IActionResult> SetActive(int id, bool isActive)
        {
            var success = await _categoryService.SetActiveAsync(id, isActive);
            if (!success)
                return BadRequest(new { message = "Failed to update category status. Category might not exist." });

            return Ok(new { message = "Category status updated successfully." });
        }  

        [Authorize(Roles = "Admin")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var success = await _categoryService.DeleteAsync(id);
            if (!success)
                return BadRequest(new { message = "Failed to delete category. Category might not exist." });

            return Ok(new { message = "Category deleted successfully." });
        }
    }
}
