using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using CRUDADO.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

namespace CRUDADO.Controllers
{
	public class HomeController : Controller
	{
		public IConfiguration Configuration { get; }
		string connectionString = "";

		public HomeController(IConfiguration configuration)
		{
			Configuration = configuration;
			connectionString = Configuration["ConnectionStrings:DefaultConnection"];
			GetNationList();
		}

		public static List<Nation> NationList;

		private void GetNationList()
		{
			List<Nation> nationList = new List<Nation>();

			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				//SqlDataReader
				connection.Open();

				string sql = "select * from Nation";
				SqlCommand command = new SqlCommand(sql, connection);

				using (SqlDataReader dataReader = command.ExecuteReader())
				{
					while (dataReader.Read())
					{
						try
						{
							Nation nation = new Nation();
							nation.ID = Convert.ToInt64(dataReader["ID"]);
							nation.Name = Convert.ToString(dataReader["Name"]);
							nation.Area = Convert.ToInt32(dataReader["Area"]);
						  nationList.Add(nation);
						}
						catch (Exception)
						{
							continue;
						}
					}
				}

				connection.Close();
			}
			NationList = nationList;
		}

		public List<Billionaire> PagingList(int pagenumber, int pagesize) 
		{
			List<Billionaire> BillionaireList = new List<Billionaire>();
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				//SqlDataReader
				connection.Open();

				string sql = "paging";
				SqlCommand command = new SqlCommand(sql, connection);
				command.CommandType = CommandType.StoredProcedure;
				command.Parameters.Add("pagenumber", SqlDbType.Int).Value = pagenumber;
				command.Parameters.Add("pagesize", SqlDbType.Int).Value = pagesize;

				using (SqlDataReader dataReader = command.ExecuteReader())
				{
					while (dataReader.Read())
					{
						try
						{
							Billionaire billionaire = new Billionaire();
							billionaire.ID = Convert.ToInt64(dataReader["ID"]);
							billionaire.Name = Convert.ToString(dataReader["Name"]);
							billionaire.BornYear = Convert.ToInt32(dataReader["BornYear"]);
							billionaire.Company = Convert.ToString(dataReader["Company"]);
							billionaire.NationID = Convert.ToInt64(dataReader["NationID"]);
							billionaire.Asset = Convert.ToDouble(dataReader["Asset"]);
							billionaire.National = NationList.FirstOrDefault(f => f.ID == billionaire.NationID);
						  BillionaireList.Add(billionaire);
						}
						catch (Exception)
						{
							continue;
						}

					}
				}

				connection.Close();
			}
			return BillionaireList;
		}

		public JsonResult Paging(int page, int pagesize) 
		{
			var pageingList = PagingList(page, pagesize);
			return Json(pageingList);
		}

		public IActionResult Index()
		{
			return View(PagingList(1, int.MaxValue));
		}
		
		public IActionResult Create()
		{
			Billionaire._NationID = -1;
			return View(new Billionaire());
		}

		[HttpPost]
		public IActionResult Create(Billionaire billionaire)
		{
			if (ModelState.IsValid)
			{
				using (SqlConnection connection = new SqlConnection(connectionString))
				{
					string sql = $"insertnew";

					using (SqlCommand command = new SqlCommand(sql, connection))
					{
						command.CommandType = CommandType.StoredProcedure;
						command.Parameters.Add("Name", SqlDbType.NVarChar).Value = billionaire.Name;
						command.Parameters.Add("BornYear", SqlDbType.Int).Value = billionaire.BornYear;
						command.Parameters.Add("Company", SqlDbType.NVarChar).Value = billionaire.Company;
						command.Parameters.Add("NationID", SqlDbType.BigInt).Value = billionaire.NationID;
						command.Parameters.Add("Asset", SqlDbType.Int).Value = billionaire.Asset;

						connection.Open();
						command.ExecuteNonQuery();
						connection.Close();
					}
					return RedirectToAction("Index");
				}
			}
			else
				return RedirectToAction("Index");
		}

		public IActionResult Update(int id)
		{
			Billionaire billionaire = new Billionaire();
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				string sql = $"getbyid";
				SqlCommand command = new SqlCommand(sql, connection);
				command.CommandType = CommandType.StoredProcedure;
				command.Parameters.Add("id", SqlDbType.NVarChar).Value = id;

				connection.Open();

				using (SqlDataReader dataReader = command.ExecuteReader())
				{
					while (dataReader.Read())
					{
						billionaire.ID = Convert.ToInt64(dataReader["id"]);
						billionaire.Name = Convert.ToString(dataReader["Name"]);
						billionaire.BornYear = Convert.ToInt32(dataReader["BornYear"]);
						billionaire.Company = Convert.ToString(dataReader["Company"]);
						billionaire.NationID = Convert.ToInt64(dataReader["NationID"]);
						billionaire.Asset = Convert.ToDouble(dataReader["Asset"]);
						Billionaire._NationID = billionaire.NationID;
					}
				}

				connection.Close();
			}
			return View(billionaire);
		}

		[HttpPost]
		[ActionName("Update")]
		public IActionResult Update_Post(Billionaire billionaire)
		{
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				string sql = $"updatebyid";
				using (SqlCommand command = new SqlCommand(sql, connection))
				{
					connection.Open();
					command.CommandType = CommandType.StoredProcedure;
					command.Parameters.Add("Name", SqlDbType.NVarChar).Value = billionaire.Name;
					command.Parameters.Add("BornYear", SqlDbType.Int).Value = billionaire.BornYear;
					command.Parameters.Add("Company", SqlDbType.NVarChar).Value = billionaire.Company ?? "";
					command.Parameters.Add("NationID", SqlDbType.BigInt).Value = billionaire.NationID;
					command.Parameters.Add("Asset", SqlDbType.Int).Value = billionaire.Asset;
					command.Parameters.Add("ID", SqlDbType.Int).Value = billionaire.ID;
					command.ExecuteNonQuery();
					connection.Close();
				}
			}

			return RedirectToAction("Index");
		}

		[HttpPost]
		public IActionResult Delete(int id)
		{
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				string sql = $"removebyid";
				using (SqlCommand command = new SqlCommand(sql, connection))
				{
					command.CommandType = CommandType.StoredProcedure;
					command.Parameters.Add("id", SqlDbType.BigInt).Value = id;
					connection.Open();
					try
					{
						command.ExecuteNonQuery();
					}
					catch (SqlException ex)
					{
						ViewBag.Result = "Operation got error: " + ex.Message;
					}
					connection.Close();
				}
			}

			return RedirectToAction("Index");
		}

		[HttpPost]
		public IActionResult DeleteAll()
		{
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				string sql = $"Delete From Billionaire";
				using (SqlCommand command = new SqlCommand(sql, connection))
				{
					connection.Open();
					try
					{
						command.ExecuteNonQuery();
					}
					catch (SqlException ex)
					{
						ViewBag.Result = "Operation got error: " + ex.Message;
					}
					connection.Close();
				}
			}

			return RedirectToAction("Index");
		}
	}
}