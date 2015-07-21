
class Vertex
  attr_accessor :color, :previousNode, :adjacent, :discoveredTimestamp, :finishedTimestamp
   
  def initialize(color = 'white', previousNode = nil, adjacent = [], discoveredTimestamp=nil, finishedTimestamp=nil) # unvisited nodes are white; discovered: gray; finished: black
    @color, @previousNode, @adjacent, @discoveredTimestamp, @finishedTimestamp = color, previousNode, adjacent, discoveredTimestamp, finishedTimestamp
  end

  def to_s
    "color: #{color}, previous: #{previousNode}, adjacent: #{adjacent}, discovered: #{discoveredTimestamp}, finished: #{finishedTimestamp}"
  end
end


$time = 0
$soughtNode
def readInGraph()
  vertices = Hash.new
  graphEdges = [
  	"AB",
    "AC",
    "BD",
    "BE",
    "BF",
    "CG",
    "GH"
  ]

  graphEdges.each do |edge|
    unless vertices[edge[0]]
	  vertices[edge[0]] = Vertex.new() 			# the value of each vertex (key) in the hash is a vector which holds the attributes of that vertex (color, timestamps, etc)
	end
	
	vertices[edge[0]].adjacent.push edge[1]	
	vertices[edge[1]] = Vertex.new 				# adj vertices are added to the vertices hash here incase they don't have any adjacent graphEdges of their own
  end
  return vertices
end



def dfs() 
  vertices = readInGraph()

  vertices.each do |vertex, data|
    if vertices[vertex].color == 'white'
	  dfs_visit(vertices, vertex) 
	end
  end
  vertices.each {|vertex, data| puts "#{vertex}: #{data}"} 			# prints out all the vertex info
end


def dfs_visit(vertices, vertex)
  $time += 1 
  vertices[vertex].discoveredTimestamp = $time
  vertices[vertex].color = 'gray' 								# node has been discovered
  
  puts "soughtNode: #{$soughtNode}"
  puts "vertex: #{vertex}"
  																#puts "vertex class: #{vertex.class}"
  																#puts "soughtNode class: #{$soughtNode.class}"
 
  #if vertices[$soughtNode.to_s].color == 'gray'   ####### BUG! both vertex and soughtNode vars are String class yet substitution doesn't work###########
  if vertices['G'].color == 'gray'				   ###### NOT SURE HOW TO SEPARATE THIS BEHAVIOR INTO ITS OWN FUNCTION #############
    puts $soughtNode
    exit true
  end
 

  vertices[vertex].adjacent.each do |adjNode|
    if vertices[adjNode].color == 'white'
	  vertices[adjNode].previousNode = vertex
	  dfs_visit(vertices, adjNode)
	end
  end

  vertices[vertex].color = 'black'							# node has no unvisited adjacent nodes
  $time += 1
  vertices[vertex].finishedTimestamp = $time
  end


  def check_for_node()									# prompts user for a node 
   puts "Which node are you looking for?"
   $soughtNode = gets.upcase.to_s
   dfs
   puts "Node not found"
  end

  check_for_node