require 'sketchup.rb'

module MJP_Transforms

  unless file_loaded?( __FILE__ )
  
    menu=UI.menu( 'Plugins' )
    menu.add_item( 'Transformations' ) { self.Transforms}
  end 
  
def self.Transforms  

##This demonstrates the simple coding needed to do transformations
##on components by digging into and changing the individual values
##in the transformation matrix
##
model = Sketchup.active_model
entities = model.entities
selection = model.selection
definitions=model.definitions
layers=model.layers
##
##input box begin
prompts = ["Transform", "What Angle?"]
defaults = ["Shear", "PI/12.0"]
list=["shear|rotx|roty|rotz","15|30|45|60|75|90"]
input = UI.inputbox prompts, defaults, list, "Learn Transformation"
##input box end
choice=input[0]
theta=input[1].to_f*PI/180.0
t=entities[0].transformation
ta=t.to_a
if choice == "shear"
  ta[4]=Math.tan(theta)
  ta[8]=Math.tan(theta)
  ta[1]=0
  ta[9]=0
  ta[2]=0
  ta[6]=0
  t=Geom::Transformation.new(ta)
  entities[0].transformation=t
end
if choice == "rotx"
  ta[5]=Math.cos(theta)
  ta[6]=Math.sin(theta)
  ta[9]=-1*Math.sin(theta)
  ta[10]=Math.cos(theta)
  t=Geom::Transformation.new(ta)
  entities[0].transformation=t
end
if choice == "roty"
  ta[0]=Math.cos(theta)
  ta[2]=-1*Math.sin(theta)
  ta[8]=Math.sin(theta)
  ta[10]=Math.cos(theta)
  t=Geom::Transformation.new(ta)
  entities[0].transformation=t
end
if choice == "rotz"
  ta[0]=Math.cos(theta)
  ta[1]=Math.sin(theta)
  ta[4]=-1*Math.sin(theta)
  ta[5]=Math.cos(theta)
  t=Geom::Transformation.new(ta)
  entities[0].transformation=t
end

end

end