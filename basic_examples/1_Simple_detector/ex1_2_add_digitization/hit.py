from gemc_api_hit import *

def define_hit(configuration):

	hit = MyHit(name="ctof", description="ctof hit definitions", identifiers="paddle", SignalThreshold="0.5*MeV",
		TimeWindow="0*ns", ProdThreshold="1.*mm", MaxStep="1*cm", delay="50*ns",
		riseTime="5*ns", fallTime="8*ns", mvToMeV=100, pedestal=-20)
	print_hit(configuration, hit)
