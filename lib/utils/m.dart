
class m
{
	static String add0(int num) => num > 9 ? '$num' : '0$num';

	static String correctMAC(String str)
	{
		String mac = '';
		for (String block in str.split(':'))
		{
			mac += '${block.length == 1 ? '0' : ''}$block:';
		}
		return mac.substring(0, mac.length - 1);
	}
}
