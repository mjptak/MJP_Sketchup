require 'sketchup.rb'

module MJP_Threads

  unless file_loaded?( __FILE__ )
  
    menu=UI.menu( 'Plugins' )
    menu.add_item( 'Threadmaker' ) { self.Threads}
  end 
  
def self.Threads 


model = Sketchup.active_model
entities = model.entities
selection = model.selection
view=model.active_view
definitions=model.definitions

r1=1
tdepth=0.05
r2=r1+tdepth
blength=1.0
tperinch=5.0
theight=1/tperinch

angincr=10*3.141592/180.0
prompts = ["Internal Diam", "External Diam", "Pitch","Length"]
defaults = ["1.0", "1.2","0.1","2"]

input = UI.inputbox prompts, defaults, "Sketchy Threads"
din=input[0].to_f
doout=input[1].to_f
pitch=input[2].to_f
blength=input[3].to_f
r1=din/2.0
r2=doout/2.0
tperinch=1.0/pitch
incrperrev=pitch/36.0


pts = []

 pts[0] = [r1, 0, 0]
 pts[1] = [r2, 0, pitch/2.0]
 pts[2] = [r1, 0, pitch]
 pts[3] = [Math.cos(angincr)*r1,Math.sin(angincr)*r1,incrperrev]
 pts[4] = [Math.cos(angincr)*r2,Math.sin(angincr)*r2,incrperrev+(pitch/2.0)]
 pts[5] = [Math.cos(angincr)*r1,Math.sin(angincr)*r1,incrperrev+pitch]
 # Add the group to the entities in the model
 group = entities.add_group

 # Get the entities within the group
 entities2 = group.entities

 # Add a face to within the group
 face = entities2.add_face(pts[0],pts[1],pts[2])
 face = entities2.add_face(pts[2],pts[1],pts[4])
 face = entities2.add_face(pts[2],pts[4],pts[5])
 face = entities2.add_face(pts[0],pts[3],pts[4])
 face = entities2.add_face(pts[0],pts[4],pts[1])
 face = entities2.add_face(pts[3],pts[5],pts[4])
 face = entities2.add_face(pts[0],pts[2],pts[3])
 face = entities2.add_face(pts[3],pts[2],pts[5])

a=group.to_component

 
for i in 1..tperinch*blength*36-1 do
  entities.add_instance(definitions[-1],[0,0,0])
  tran3=Geom::Transformation.new([0,0,0],[0,0,1],i*3.14159/18.0)
  tran4=Geom::Transformation.new([0,0,incrperrev*i])
  #i.times{
  #tran3=Geom::Transformation.new([0,0,0],[0,0,1],3.14159/18.0)
  #tran4=Geom::Transformation.new([0,0,incrperrev])
  entities.transform_entities(tran3,entities[-1])
  entities.transform_entities(tran4,entities[-1])
  #}
end

end

end