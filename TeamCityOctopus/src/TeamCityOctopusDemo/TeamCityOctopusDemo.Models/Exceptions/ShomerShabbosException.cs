using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TeamCityOctopusDemo.Models.Exceptions
{
	public class ShomerShabbosException : Exception
	{
		public override string Message
		{
			get
			{
				return "Shomer Shabbos!";
			}
		}
	}
}
