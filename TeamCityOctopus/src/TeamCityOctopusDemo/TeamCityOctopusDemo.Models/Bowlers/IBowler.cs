using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TeamCityOctopusDemo.Models.Bowlers
{
	public interface IBowler
	{
		bool ShouldIRoll( DateTime dateTime );
	}
}
