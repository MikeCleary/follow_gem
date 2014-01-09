require 'spec_helper'

describe User do 
  it { should have_many(:followers)}
  it { should have_many(:following)}

  it { should have_many(:users_following).through(:followers) }
  it { should have_many(:users_followed).through(:following) }  
end