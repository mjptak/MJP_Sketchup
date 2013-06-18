require 'sketchup.rb'

module MJP_KaTrackingApp

  unless file_loaded?( __FILE__ )
  
    menu=UI.menu( 'Plugins' )
    menu.add_item( 'KA Tracking' ) { self.KaTracking }
  end 
  
  
  

  def self.movething(position)
      model = Sketchup.active_model
      entities = model.entities
      selection = model.selection
      view=model.active_view
      target=position[0]
      entities.each{|e|
      if e.name == target
        #UI::messagebox("target acquired")
        postran=e.transformation
        posarray=postran.to_a
        posarray[-4]=position[1]
        posarray[-3]=position[2]
        posarray[-2]=position[3]
        postran=Geom::Transformation.new(posarray)
        e.transformation=postran
        newview=view.refresh
      end
     }
   end
   
   def self.KaTracking




##This file runs locally based on the value set in the url
##It should also be able to get information sent to it from any webpage
##which accesses javascript.  The information first flow from javascript to
##ruby and then back out to a javasript function.  This all is an example
##of callback functions.  Appears to be limited to the WD.

wd=UI::WebDialog.new(
"My First WebDialog", true, "",
400, 600, 100, 100, false )



wd.add_action_callback("second_ac") do |js_wd, message|
  meslist=message.split('#')
  for i in (0..meslist.length-1)
    if i%4 != 0
      meslist[i]=meslist[i].to_f
    end
  end
  for i in (0..((meslist.length)/4)-1)
    templist=[meslist[i*4],meslist[i*4+1],meslist[i*4+2],meslist[i*4+3]]
    movething(templist)
    if i == 0
      puts templist[0]
      puts templist[1]
      puts templist[2]
      puts templist[3]
    end
  end
  puts "moved1"

end

##wd.set_url "http://localhost:8000/index.php"
wd.set_url "http://www.we4dkids.com/rjtalk3/index.php"

wd.show()

end

end
