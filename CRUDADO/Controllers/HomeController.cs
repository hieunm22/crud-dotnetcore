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

		public HomeController(IConfiguration configuration)
		{
			Configuration = configuration;
			GetNationList();
		}

		public static List<Nation> NationList;

		private void GetNationList()
		{
			List<Nation> nationList = new List<Nation>();

			string connectionString = Configuration["ConnectionStrings:DefaultConnection"];
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

		public IActionResult Index()
		{
			List<Billionaire> BillionaireList = new List<Billionaire>();

			string connectionString = Configuration["ConnectionStrings:DefaultConnection"];
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				//SqlDataReader
				connection.Open();

				string sql = "select * from Billionaire";
				SqlCommand command = new SqlCommand(sql, connection);

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
			return View(BillionaireList);
		}

		public IActionResult Create()
		{
			Billionaire._NationID = -1;
			return View(new Billionaire());
		}

		[HttpPost]
		public IActionResult Create(Billionaire Billionaire)
		{
			if (ModelState.IsValid)
			{
				string connectionString = Configuration["ConnectionStrings:DefaultConnection"];
				using (SqlConnection connection = new SqlConnection(connectionString))
				{
					string sql = $"insert into Billionaire(Name, BornYear, Company, NationID, Asset) values (N'{Billionaire.Name}', '{Billionaire.BornYear}', N'{Billionaire.Company}', {Billionaire.NationID}, '{Billionaire.Asset}')";

					using (SqlCommand command = new SqlCommand(sql, connection))
					{
						command.CommandType = CommandType.Text;

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
			string connectionString = Configuration["ConnectionStrings:DefaultConnection"];

			Billionaire billionaire = new Billionaire();
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				string sql = $"Select * From Billionaire Where Id='{id}'";
				SqlCommand command = new SqlCommand(sql, connection);

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
		public IActionResult Update_Post(Billionaire Billionaire)
		{
			string connectionString = Configuration["ConnectionStrings:DefaultConnection"];
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				string sql = $"Update Billionaire SET Name=N'{Billionaire.Name}', BornYear='{Billionaire.BornYear}', Company=N'{Billionaire.Company}', NationID=N'{Billionaire.NationID}', Asset='{Billionaire.Asset}' Where Id='{Billionaire.ID}'";
				using (SqlCommand command = new SqlCommand(sql, connection))
				{
					connection.Open();
					command.ExecuteNonQuery();
					connection.Close();
				}
			}

			return RedirectToAction("Index");
		}

		[HttpPost]
		public IActionResult Delete(int id)
		{
			string connectionString = Configuration["ConnectionStrings:DefaultConnection"];
			using (SqlConnection connection = new SqlConnection(connectionString))
			{
				string sql = $"Delete From Billionaire Where Id='{id}'";
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

		[HttpPost]
		public IActionResult DeleteAll()
		{
			string connectionString = Configuration["ConnectionStrings:DefaultConnection"];
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